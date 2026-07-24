{ pkgs, ... }:

let
  kbdBacklight = pkgs.writeShellScriptBin "kbd-backlight" ''
    direction="''${1:-up}"

    # Find keyboard backlight device
    device=""
    for candidate in /sys/class/leds/*kbd_backlight*; do
      if [[ -e $candidate ]]; then
        device="$(basename "$candidate")"
        break
      fi
    done

    if [[ -z $device ]]; then
      echo "No keyboard backlight device found" >&2
      exit 1
    fi

    if [[ "$direction" == "off" ]]; then
      ${pkgs.brightnessctl}/bin/brightnessctl -sd "$device" set 0 >/dev/null
      ${pkgs.swayosd}/bin/swayosd-client --custom-progress 0.0 --custom-icon "keyboard-brightness-symbolic"
      exit 0
    elif [[ "$direction" == "restore" ]]; then
      ${pkgs.brightnessctl}/bin/brightnessctl -rd "$device" >/dev/null
      exit 0
    fi

    max_brightness="$(${pkgs.brightnessctl}/bin/brightnessctl -d "$device" max)"
    current_brightness="$(${pkgs.brightnessctl}/bin/brightnessctl -d "$device" get)"

    step=$(( max_brightness / 10 ))
    (( step < 1 )) && step=1

    if [[ "$direction" == "cycle" ]]; then
      new_brightness=$(( current_brightness + step ))
      (( new_brightness > max_brightness )) && new_brightness=0
    elif [[ "$direction" == "up" ]]; then
      new_brightness=$(( current_brightness + step ))
      (( new_brightness > max_brightness )) && new_brightness=$max_brightness
    else
      new_brightness=$(( current_brightness - step ))
      (( new_brightness < 0 )) && new_brightness=0
    fi

    ${pkgs.brightnessctl}/bin/brightnessctl -d "$device" set "$new_brightness" >/dev/null

    progress=$(awk "BEGIN {print $new_brightness / $max_brightness}")

    ${pkgs.swayosd}/bin/swayosd-client --custom-progress "$progress" --custom-icon "keyboard-brightness-symbolic"
  '';

  touchpadToggle = pkgs.writeShellScriptBin "touchpad-toggle" ''
    STATE_CONF="$HOME/.local/state/hypr/touchpad-disabled.conf"

    # Find the exact touchpad device name from hyprctl
    device=$(${pkgs.hyprland}/bin/hyprctl devices -j | ${pkgs.jq}/bin/jq -r '
      .mice[] | select(.name | ascii_downcase | contains("touchpad")).name
    ' | head -n 1)

    if [[ -z "$device" ]]; then
      echo "No touchpad device found" >&2
      exit 1
    fi

    enable() {
      # Using 1/true for enabled
      ${pkgs.hyprland}/bin/hyprctl keyword "device[$device]:enabled" 1 >/dev/null
      rm -f "$STATE_CONF"
      ${pkgs.swayosd}/bin/swayosd-client --custom-icon input-touchpad-symbolic --custom-message "Touchpad Enabled"
    }

    disable() {
      # Using 0/false for disabled
      ${pkgs.hyprland}/bin/hyprctl keyword "device[$device]:enabled" 0 >/dev/null
      mkdir -p "$(dirname "$STATE_CONF")"
      printf 'device {\n    name = %s\n    enabled = false\n}\n' "$device" > "$STATE_CONF"
      ${pkgs.swayosd}/bin/swayosd-client --custom-icon touchpad-disabled-symbolic --custom-message "Touchpad Disabled"
    }

    case "''${1:-toggle}" in
      on) enable ;;
      off) disable ;;
      toggle) 
        if [[ -f "$STATE_CONF" ]]; then 
          enable
        else 
          disable 
        fi 
        ;;
    esac
  '';
  audioOutputSwitch = pkgs.writeShellScriptBin "audio-output-switch" ''
    sinks=$(${pkgs.pulseaudio}/bin/pactl -f json list sinks | ${pkgs.jq}/bin/jq '[.[] | select((.ports | length == 0) or ([.ports[]? | .availability != "not available"] | any))]')
    sinks_count=$(echo "$sinks" | ${pkgs.jq}/bin/jq '. | length')

    if (( sinks_count == 0 )); then
      ${pkgs.swayosd}/bin/swayosd-client --custom-message "No audio devices found"
      exit 1
    fi

    current_sink_name=$(${pkgs.pulseaudio}/bin/pactl get-default-sink)
    current_sink_index=$(echo "$sinks" | ${pkgs.jq}/bin/jq -r --arg name "$current_sink_name" 'map(.name) | index($name)')

    if [[ "$current_sink_index" != "null" ]]; then
      next_sink_index=$(((current_sink_index + 1) % sinks_count))
    else
      next_sink_index=0
    fi

    next_sink=$(echo "$sinks" | ${pkgs.jq}/bin/jq -r ".[$next_sink_index]")
    next_sink_name=$(echo "$next_sink" | ${pkgs.jq}/bin/jq -r '.name')

    next_sink_description=$(echo "$next_sink" | ${pkgs.jq}/bin/jq -r '.description')
    if [[ "$next_sink_description" == "(null)" ]] || [[ "$next_sink_description" == "null" ]] || [[ -z "$next_sink_description" ]]; then
      device_id=$(echo "$next_sink" | ${pkgs.jq}/bin/jq -r '.properties."device.id"')
      if [[ "$device_id" != "null" ]] && [[ -n "$device_id" ]]; then
        next_sink_description=$(${pkgs.wireplumber}/bin/wpctl status | grep -E "^\s*│?\s+''${device_id}\." | sed -E 's/^.*[0-9]+\.\s+//' | sed -E 's/\s+\[.*$//')
      fi
      if [[ -z "$next_sink_description" ]]; then
        sink_id=$(echo "$next_sink" | ${pkgs.jq}/bin/jq -r '.properties."object.id"')
        next_sink_description=$(${pkgs.wireplumber}/bin/wpctl status | grep -E "\s+\*?\s+''${sink_id}\." | sed -E 's/^.*[0-9]+\.\s+//' | sed -E 's/\s+\[.*$//')
      fi
    fi

    next_sink_volume=$(echo "$next_sink" | ${pkgs.jq}/bin/jq -r '.volume | to_entries[0].value.value_percent | sub("%"; "")')
    next_sink_is_muted=$(echo "$next_sink" | ${pkgs.jq}/bin/jq -r '.mute')

    if [[ "$next_sink_is_muted" == "true" ]] || (( next_sink_volume == 0 )); then
      icon_state="muted"
    elif (( next_sink_volume <= 33 )); then
      icon_state="low"
    elif (( next_sink_volume <= 66 )); then
      icon_state="medium"
    else
      icon_state="high"
    fi

    next_sink_volume_icon="sink-volume-''${icon_state}-symbolic"

    if [[ "$next_sink_name" != "$current_sink_name" ]]; then
      next_sink_wpid=$(echo "$next_sink" | ${pkgs.jq}/bin/jq -r '.properties."object.id"')
      ${pkgs.wireplumber}/bin/wpctl set-default "$next_sink_wpid"
    fi

    # Using standard swayosd-client wrapper
    ${pkgs.swayosd}/bin/swayosd-client \
      --custom-message "$next_sink_description" \
      --custom-icon "$next_sink_volume_icon"
  '';

  displayMirror = pkgs.writeShellScriptBin "display-mirror" ''
    TOGGLE_FLAG="$HOME/.local/state/hypr/internal-monitor-mirror.conf"

    # Get monitor names dynamically
    INTERNAL=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[] | select(.name | contains("eDP")).name' | head -n 1)
    EXTERNAL=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[] | select(.name | contains("eDP") | not).name' | head -n 1)

    enable() {
      if [[ -z "$EXTERNAL" ]]; then
        ${pkgs.libnotify}/bin/notify-send -u low "󰍹    No external monitors found for mirror"
        exit 1
      fi

      if [[ -z "$INTERNAL" ]]; then
        ${pkgs.libnotify}/bin/notify-send -u low "󰍹    No laptop monitor found to mirror"
        exit 1
      fi

      mkdir -p "$(dirname "$TOGGLE_FLAG")"
      echo "monitor=$EXTERNAL, preferred, auto, 1, mirror, $INTERNAL" > "$TOGGLE_FLAG"
      ${pkgs.libnotify}/bin/notify-send -u low "󰍹    Mirroring enabled ($EXTERNAL)"
      ${pkgs.hyprland}/bin/hyprctl reload
    }

    disable() {
      if [[ -f "$TOGGLE_FLAG" ]]; then
        rm -f "$TOGGLE_FLAG"
        ${pkgs.libnotify}/bin/notify-send -u low "󰍹    Extended mode restored"
        ${pkgs.hyprland}/bin/hyprctl reload
      fi
    }

    case "$1" in
      on) enable ;;
      off) disable ;;
      toggle) if [[ -f "$TOGGLE_FLAG" ]]; then disable; else enable; fi ;;
      *) echo "Usage: display-mirror {on|off|toggle}" >&2; exit 1 ;;
    esac
  '';
  screenshotCapture = pkgs.writeShellScriptBin "screenshot-capture" ''
      DIR="$HOME/Pictures/Screenshots"
      mkdir -p "$DIR"
      
      FILE="$DIR/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"
      MODE="''${1:-region}" # Default to region mode
      EDITOR="satty"        # Change to your preferred editor

      case "$MODE" in
        fullscreen)
          ${pkgs.grim}/bin/grim "$FILE"
          ;;
        region|*)
          ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" "$FILE"
          ;;
      esac

      # Ensure the file was successfully captured
      if [ -f "$FILE" ]; then
        ${pkgs.wl-clipboard}/bin/wl-copy < "$FILE"
        
        # Clean helper to open the editor cleanly
        open_editor() {
          if [ "$EDITOR" = "satty" ]; then
            ${pkgs.satty}/bin/satty --filename "$FILE" \
              --output-filename "$FILE" \
              --actions-on-enter save-to-clipboard \
              --save-after-copy \
              --copy-command '${pkgs.wl-clipboard}/bin/wl-copy'
          else
            $EDITOR "$FILE"
          fi
        }

        # Send notification with interactive button and capture response
        ACTION=$(${pkgs.libnotify}/bin/notify-send \
          "Screenshot saved to clipboard and file" \
          "Click here or press Super + Alt + , to edit" \
          -t 10000 \
          -i "$FILE" \
          -A "default=edit")

        if [ "$ACTION" = "default" ]; then
          open_editor
        fi
      fi
    '';
  powerMenu = pkgs.writeShellScriptBin "power-menu" ''
      selected=$(printf " Suspend\n󰍁 Lock\n󰜉 Restart\n󰐥 Shutdown" | ${pkgs.walker}/bin/walker --dmenu -p 'Power Menu…' --width 300 --height 200)
      case "$selected" in
          " Suspend")   systemctl suspend ;;
          "󰍁 Lock")      ${pkgs.hyprlock}/bin/hyprlock ;;
          "󰜉 Restart")   systemctl reboot ;;
          "󰐥 Shutdown")  systemctl poweroff ;;
      esac
    '';
  powerProfileMenu = pkgs.writeShellScriptBin "power-profile-menu" ''
      profile=$(powerprofilesctl list | awk '/^[[:space:]*]*[a-zA-Z0-9\-]+:$/ { gsub(/^[*[:space:]]+|:$/, ""); print }' | walker --dmenu -p 'Power Profile…' --width 300 --height 150)
      if [ -n "$profile" ]; then
          powerprofilesctl set "$profile"
      fi
    '';
in {
  home.packages = [
    kbdBacklight
    touchpadToggle
    audioOutputSwitch
    displayMirror
    screenshotCapture
    powerMenu
    powerProfileMenu
  ];
}
