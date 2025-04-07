{
  ...
}:
{
  # appimage.nix
  mySystem.programs.appimage.enable = true;

  # display-manager.nix
  mySystem.services.displayManager = {
    ly.enable = false;
    sddm.enable = true;
  };

  # firefox.nix
  mySystem.programs.firefox.enable = true;

  # git.nix
  mySystem.programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # kde.nix :: KDE Plasma Desktop
  mySystem.programs.kde-pim.enable = false;
  mySystem.programs.kdeconnect.enable = true;
  mySystem.services.desktopManager.plasma6.enable = true;

  # lazygit.nix
  mySystem.programs.lazygit.enable = true;

  # mtr.nix
  mySystem.programs.mtr.enable = true;

  # nix-flatpak.nix
  mySystem.services.flatpak.enable = true;

  # nixvim.nix
  mySystem.programs.nixvim.enable = true;

  # ollama.nix
  mySystem.services.ollama = {
    enable = false;
    acceleration = null;
  };

  # open-webui.nix
  mySystem.services.open-webui = {
    enable = false;
    # port = 3000; # Default port
  };

  # packages.nix
  mySystem.packages = {
    baseline = true;
    cli._all = true;
    gui = true;
    guiShell.kde = true;
  };

  # nix-snapd (from flake) :: Enables Canonical Snap packages store
  services.snap.enable = true;

  # tmux.nix
  mySystem.programs.tmux = {
    enable = true;
    extraConfig = "set -g status-style bg=colour53,fg=white";
  };

  # yazi.nix
  mySystem.package.yazi.enable = true;
  mySystem.programs.yazi.enable = false;

  # zsh.nix
  mySystem.programs.zsh.enable = true; # If disabled, this option is automatically enabled when `users.defaultUserShell` is ="zsh"

  # xdg-portal.nix
  mySystem.xdg.portal.enable = true;
}
