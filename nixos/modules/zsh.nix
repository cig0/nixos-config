{ pkgs, ... }:

{
  programs.command-not-found.enable = false;

  # Zsh
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    interactiveShellInit = ''
      # Needs https://github.com/nix-community/nix-index
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    '';
    syntaxHighlighting.enable = true;
    shellAliases = {
      nixup = "sudo nixos-rebuild switch";
    };
    histSize = 10000;
    histFile = "$HOME/.local/share/zsh/zsh_history";

    # Plugins
    ohMyZsh = {
      enable = true;
      plugins = [ "fzf" "history-substring-search" ];
    };
  };
}
