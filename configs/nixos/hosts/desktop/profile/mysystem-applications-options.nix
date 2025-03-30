{
  ...
}:
{
  mySystem = {
    programs.appimage.enable = true;
    programs.firefox.enable = true;
    services.flatpak.enable = true;
    programs.git = {
      enable = true;
      lfs.enable = true;
    };
    # programs.krew.enable = false; # WIP
    programs.lazygit.enable = true;
    programs.nixvim.enable = true;
    services.ollama = {
      enable = false;
      acceleration = null;
    };
    services.open-webui = {
      enable = false;
      # port = 3000; # Default port
    };
    services.tailscale.enable = true;
    programs.tmux.enable = true;
    package.yazi.enable = true;
    programs.yazi.enable = false;
    programs.zsh.enable = true; # If disabled, this option is automatically enabled when users.defaultUserShell="zsh" is set
    packages = {
      baseline = true;
      cli._all = true;
      gui = true;
      guiShell.kde = true;
    };
  };
}
