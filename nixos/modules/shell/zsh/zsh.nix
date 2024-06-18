{ pkgs, ... }:

let
  shellConfig = import ./shellConfig.nix { inherit pkgs; };
in
{
  programs.command-not-found.enable = false;

  # Zsh
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    interactiveShellInit = shellConfig.interactiveShellInit;
    loginShellInit = shellConfig.loginShellInit;
    setOptions = shellConfig.setOptions;
    shellAliases = shellConfig.shellAliases;
    syntaxHighlighting.enable = true;

    # History is managed by Atuin
    histSize = 20000;
    histFile = "$HOME/.local/share/zsh/zsh_history";

    ohMyZsh = {
      enable = true;
      plugins = shellConfig.ohMyZsh.plugins;
    };
  };
}