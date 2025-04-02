{
  ...
}:
{
  mySystem = {
    # appimage.nix
    programs.appimage.enable = true;

    # display-manager.nix
    services.displayManager = {
      ly.enable = false;
      sddm.enable = true;
    };

    # firefox.nix
    programs.firefox.enable = true;

    # git.nix
    programs.git = {
      enable = true;
      lfs.enable = true;
    };

    # kde.nix :: KDE Plasma Desktop
    programs.kde-pim.enable = false;
    programs.kdeconnect.enable = true;
    services.desktopManager.plasma6.enable = true;

    # lazygit.nix
    programs.lazygit.enable = true;

    # mtr.nix
    programs.mtr.enable = true;

    # nix-flatpak.nix
    services.flatpak.enable = true;

    # nixvim.nix
    programs.nixvim.enable = true;

    # ollama.nix
    services.ollama = {
      enable = false;
      acceleration = null;
    };

    # open-webui.nix
    services.open-webui = {
      enable = false;
      # port = 3000; # Default port
    };

    # packages.nix
    packages = {
      baseline = true;
      cli._all = true;
      gui = true;
      guiShell.kde = true;
    };

    # tmux.nix
    programs.tmux.enable = true;

    # yazi.nix
    package.yazi.enable = true;
    programs.yazi.enable = false;

    # zsh.nix
    programs.zsh.enable = true; # If disabled, this option is automatically enabled when `users.defaultUserShell` is ="zsh"

    # xdg-portal.nix
    xdg.portal.enable = true;
  };

  # nix-snapd (from flake) :: Enables Canonical Snap packages store
  services.snap.enable = true;
}

# {
#   ...
# }:
# {
#   services.snap.enable = true; # nix-snapd

#   mySystem = {
#     programs.appimage.enable = true;
#     programs.firefox.enable = true;
#     services.flatpak.enable = true;
#     programs.git = {
#       enable = true;
#       lfs.enable = true;
#     };
#     # programs.krew.enable = false; # WIP
#     programs.lazygit.enable = true;
#     programs.mtr.enable = true;
#     programs.nixvim.enable = true;
#     services.ollama = {
#       enable = false;
#       acceleration = null;
#     };
#     services.open-webui = {
#       enable = false;
#       # port = 3000; # Default port
#     };
#     services.tailscale.enable = true;
#     programs.tmux.enable = true;
#     package.yazi.enable = true;
#     programs.yazi.enable = false;
#     programs.zsh.enable = true; # If disabled, this option is automatically enabled when users.defaultUserShell="zsh" is set
#     packages = {
#       baseline = true;
#       cli._all = true;
#       gui = true;
#       guiShell.kde = true;
#     };

#     # GUI Shell - KDE Plasma Desktop
#     programs.kde-pim.enable = false;
#     programs.kdeconnect.enable = true;
#     services.displayManager = {
#       ly.enable = false;
#       sddm.enable = true;
#     };
#     services.desktopManager.plasma6.enable = true;
#     xdg.portal.enable = true;
#   };
# }
