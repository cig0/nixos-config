{ pkgs, ... }:

let
  allAliases = (import ./aliases.nix {}).allAliases;
  zshConfig = import ./zshConfig.nix { inherit pkgs; };

in {
  programs.command-not-found.enable = false;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    interactiveShellInit = zshConfig.interactiveShellInit;
    loginShellInit = zshConfig.loginShellInit;
    shellInit = zshConfig.shellInit;
    setOptions = zshConfig.setOptions;
    shellAliases = allAliases // zshConfig.shellAliases;
    syntaxHighlighting.enable = true;

    # History is managed by Atuin.
    histSize = 20000;
    histFile = "$HOME/.zsh_history";

    ohMyZsh = {
      enable = true;
      plugins = zshConfig.ohMyZsh.plugins;
    };
  };
}