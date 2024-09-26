# https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
 # Note!!! Home Manageer is configured to use the unstable release channel, defined in the flake.

# { modulesPath, unstablePkgs, ... }:
{ unstablePkgs, ... }:

{
  # imports = [
  #   (modulesPath + "/profiles/minimal.nix")
  # ];

  home-manager = {
    backupFileExtension = "bkp";
    useGlobalPkgs = false;
    useUserPackages = true;
    users = {
      cig0 = { ... }: {
        # Define user-specific packages and configurations
        home.packages = with unstablePkgs; [
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
          zoom-us

          # KDE Apps
          # calligra

          # Multimedia
          cinelerra
          davinci-resolve
          exiftool
          gimp-with-plugins
          imagemagick
          jp2a
          libheif
          lightworks
          mediainfo
          mpv
          olive-editor
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
          sublime4
          vscode-fhs
          zig

          # Security
          keepassxc
            # Web
            burpsuite
            mitmproxy
            nikto

          # Terminal
          terminal-parrot
          yazi-unwrapped
          wiki-tui

          # Virtualization
          virt-viewer

          # Web
          # (unstablePkgs.wrapFirefox (unstablePkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})

          # Everything else
          zola
        ];

        # The state version is required and should stay at the version you
        # originally installed.
        home.stateVersion = "23.11";
      };

      fine = { ... }: {
        home.packages = with unstablePkgs; [
        ];

        home.stateVersion = "23.11";
      };
    };
  };
}