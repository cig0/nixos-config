# home.nix - https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
# This file contains the configuration for Home Manager.
#
# The unstablePkgs argument is defined in ../flake.nix

# { modulesPath, unstablePkgs, ... }:
{ pkgs, unstablePkgs, ... }:

{
  # imports = [
  #   (modulesPath + "/profiles/minimal.nix")
  # ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = false;
    useUserPackages = true;
    users = {
      cig0 = { ... }: {
        # Define user-specific packages and configurations
        home.packages =
          with pkgs; [
          ] ++
          (with unstablePkgs; [
          # AI
            aichat
            (lmstudio.override {
              commandLineArgs = [
                "--enable-features=VaapiVideoDecodeLinuxGL"
                "--ignore-gpu-blocklist"
                "--enable-zero-copy"
                "--enable-features=UseOzonePlatform"
                "--ozone-platform=wayland"
              ];
            })
            oterm

          # Comms
            discordo
            zoom-us

          # KDE Apps
            # calligra

          # Multimedia
            # cinelerra
            # davinci-resolve
            exiftool
            gimp-with-plugins
            imagemagick
            jp2a
            libheif
            lightworks
            mediainfo
            mpv
            # olive-editor
            pngcrush
            yt-dlp

          # Productivity
            # (obsidian.override {
            #   commandLineArgs = [
            #     "--enable-features=VaapiVideoDecodeLinuxGL"
            #     "--ignore-gpu-blocklist"
            #     "--enable-zero-copy"
            #     "--enable-features=UseOzonePlatform"
            #     "--ozone-platform=wayland"
            #   ];
            # })
            # todoist-electron

          # Programming
            sublime-merge
            vscode-fhs

          # Security
            keepassxc
              # Web
              burpsuite
              mitmproxy
              nikto

          # Virtualization
            virt-viewer

          # Web
            # (unstablePkgs.wrapFirefox (unstablePkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})

          # Everything else
              wiki-tui
        ]);

        # The state version is required and should stay at the version you
        # originally installed.
        home.stateVersion = "24.11";
      };

      # doomguy = { ... }: {
      #   home.packages =
      #     with pkgs; [
      #     ] ++
      #     (with unstablePkgs; [
      #   ]);

      #   home.stateVersion = "24.11";
      # };

      # fine = { ... }: {
      #   home.packages =
      #     with pkgs; [
      #     ] ++
      #     (with unstablePkgs; [
      #   ]);

      #   home.stateVersion = "24.11";
      # };
    };
  };
}
