let
  userSettings =
    (import ./common-settings.nix)
    // {
      packages.cli._all = true;
      packages.gui = true;
      packages.guiShell.kde = true;
      programs.git.lfs.enable = true;
      programs.lazygit.enable = true;
      programs.firefox.enable = true;
      services.flatpak.enable = true;
      programs.kdeconnect.enable = true;
      programs.kde-pim.enable = false;

      # GUI shell
      xdg.portal.enable = true;

      # Home Manager
      home-manager.enable = true;

      # System
      programs.nix-ld.enable = true;
      # System - Audio
      audio-subsystem.enable = true;
      services.speechd.enable = true;

      # System - User management
      users.users.doomguy = true;

      # Virtualisation
      virtualisation.incus.enable = true;
      virtualisation.libvirtd.enable = true;
    };
in
  userSettings
