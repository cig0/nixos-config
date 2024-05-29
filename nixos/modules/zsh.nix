{
  # Zsh
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
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
