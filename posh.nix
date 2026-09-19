{ pkgs, ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true; # Change to enableBashIntegration or enableFishIntegration if needed

    settings = {
      version = 3;
      final_space = true;
      console_title_template = "{{ .Shell }} in {{ .Folder }}";

      # TRANSIENT PROMPT FEATURE
      transient_prompt = {
        template = "❯ ";
        foreground = "cyan";
        background = "transparent";
      };

      blocks = [
        # =========================================================================
        # BLOCK 1: TOP BAR (Directory, Shell/Dev Envs, Git)
        # =========================================================================
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            # --- DYNAMIC DEV SHELL INDICATOR ---
            {
              type = "text";
              style = "plain";
              foreground = "p:peach";
              background = "transparent";
              template = ''{{ if .Env.DEV_SHELL_NAME }}{{ $parts := split "|" .Env.DEV_SHELL_NAME }}[{{ index $parts 0 }}] {{ end }}'';
            }

            # --- GENERIC NIX SHELL INDICATOR ---
            {
              type = "text";
              style = "plain";
              foreground = "cyan";
              background = "transparent";
              template = ''{{ if or .Env.IN_NIX_SHELL .Env.NIX_SHELL_PACKAGES }}[nix] {{ end }}'';
            }

            # --- DIRECTORY SEGMENT (Starship-style Repo Root Format) ---
            {
              type = "path";
              style = "plain";
              background = "transparent";
              cache_duration = "none";
              properties = {
                style = "mixed";
                max_depth = 2;
                truncation_symbol = "…/";
              };
              template = ''<bold cyan>{{ .Path }}</bold>{{ if not .Writable }} 🔒{{ end }} '';
            }

            # --- GIT SEGMENT ---
            {
              type = "git";
              style = "plain";
              foreground = "cyan";
              background = "transparent";
              properties = {
                branch_icon = "";
                commit_icon = "@";
                fetch_status = true;
                cache_duration = "none";
              };
              template = ''
                <i>{{ .HEAD }}</i>
                {{- if or .Working.Changed .Staging.Changed }}  {{- end }}
                {{- if gt .Ahead 0 }} ⇡{{ .Ahead }} {{- end }}
                {{- if gt .Behind 0 }} ⇣{{ .Behind }} {{- end }}
                {{- if gt .Working.Untracked 0 }} ? {{- end }}
                {{- if gt .Working.Unmerged 0 }}  {{- end }}
                {{- if and (not .Working.Changed) (not .Staging.Changed) (eq .Ahead 0) (eq .Behind 0) }}  {{- end }}
              '';
            }
          ];
        }
        # =========================================================================
        # BLOCK 2: INPUT CHARACTER LINE
        # =========================================================================
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "text";
              style = "plain";
              background = "transparent";
              cache_duration = "none";
              template = ''{{ if gt .Code 0 }}<bold cyan>✗</bold>{{ else }}<bold cyan>❯</bold>{{ end }} '';
            }
          ];
        }
      ];
    };
  };
}
