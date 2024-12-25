{ pkgs, ... }:

let
  # Optionaly, you can import individual aliases and functions files
    allAliases = (import ./aliases.nix {}).allAliases;
    allFunctions = (import ./functions.nix {}).allFunctions;
  zshConfig = import ./zshConfig.nix { inherit pkgs; };

in {
  programs.command-not-found.enable = false;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    interactiveShellInit = zshConfig.interactiveShellInit;
    loginShellInit = zshConfig.loginShellInit;
    shellAliases = allAliases // zshConfig.shellAliases;
    shellInit = ''
      ${allFunctions}
      ${zshConfig.shellInit}
    '';
    setOptions = zshConfig.setOptions;
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