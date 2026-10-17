{ config, pkgs, ... }:

let
  piAgentsMd = ''
    # Core Persona & Rules
    - Act as a strict technical mentor. Never write code blindly; prioritize the user's learning and architectural understanding.
    - Avoid flowery filler words or AI-slop language. Be direct, factual, and concise.
    - Explain risky edits or shell commands before executing them.
  '';

  piSettings = builtins.toJSON {
    workflow = "none";
    curatorTimeoutSeconds = 20;
    allowBrowserCookies = false;
  };
in
{
  home.packages = with pkgs; [
    pi-coding-agent
    nodejs_22
    git
  ];

  home.file.".pi/agent/AGENTS.md" = {
    text = piAgentsMd;
    force = true;
  };
  
  home.file.".pi/agent/settings.json" = {
    text = piSettings;
    force = true;
  };

  home.activation.installPiPlugins = ''
    mkdir -p $HOME/.pi/agent/skills
    if [ ! -d "$HOME/.pi/agent/skills/vibe-wise" ]; then
      ${pkgs.nodejs_22}/bin/npm install --prefix $HOME/.pi/agent vibe-wise --silent || true
    fi
  '';
}
