{ config, lib, pkgs, pkgsUnstable, ... }:

let
  cfgPkgsBaseline = config.mySystem.pkgsBaseline;
  cfgPkgsCli_all = config.mySystem.pkgsCli._all;
  cfgPkgsCliAi = config.mySystem.pkgsCli.ai;
  cfgPkgsCliBackup = config.mySystem.pkgsCli.backup;
  cfgPkgsCliComms = config.mySystem.pkgsCli.comms;
  cfgPkgsCliCloudNativeTools = config.mySystem.pkgsCli.cloudNativeTools;
  cfgPkgsCliMultimedia = config.mySystem.pkgsCli.multimedia;
  cfgPkgsCliProgramming = config.mySystem.pkgsCli.programming;
  cfgPkgsCliSecurity = config.mySystem.pkgsCli.security;
  cfgPkgsCliUtilities = config.mySystem.pkgsCli.utilities;
  cfgPkgsCliVcs = config.mySystem.pkgsCli.vcs;
  cfgPkgsCliWeb = config.mySystem.pkgsCli.web;
  cfgPkgsGui = config.mySystem.pkgsGui;
  cfgPkgsGuiShellKde = config.mySystem.pkgsGuiShell.kde;
  cfgPkgsNvidia = config.mySystem.pkgsNvidia;

  pkgsBaseline =
    with pkgs; [
      # Nix
        # LSP
          nil
          nixd
        alejandra  # The Uncompromising Nix Code Formatter :: https://github.com/kamadorueda/alejandra
        comma
        devpod
        fh  # fh, the official FlakeHub CLI :: https://github.com/DeterminateSystems/fh
        hydra-check
        manix
        nh
        nickel
        niv
        nix-diff
        nix-index
        nix-melt
        nix-tree
        nixfmt-classic
        nixpkgs-fmt
        nixpkgs-review
        nvd
        rippkgs
        vulnix

      # Python
        python312
        python312Packages.ipython
    ] ++
    (with pkgsUnstable; [
      # Monitoring & Observability
        btop
        glances
        hyperfine
        inxi
        iotop
        lm_sensors
        s-tui

      # Networking
        aria2
        # bind
        dnstracer
        gping # Ping, but with a graph :: https://github.com/orf/gping
        grpcurl
        httpie
        inetutils
        iperf
        iw
        lftp
        nfstrace
        nmap
        ookla-speedtest
        prettyping # prettyping is a wrapper around the standard ping tool, making the output prettier, more colorful, more compact, and easier to read :: https://github.com/deniconfig, lib,lsonsa/prettyping
        socat
        sshfs-fuse
        tcpdump
        traceroute
        whois

      # Other utilities
        at
        bat
        chezmoi
        cyme # https://github.com/tuna-f1sh/cyme :: List system USB buses and devices.
        difftastic
        delta
        direnv
        dmidecode
        fd
        fdupes
        file
        fx
        fzf
        getent
        goaccess
        joshuto
        jq
        just # https://github.com/casey/just :: A handy way to save and run project-specific commands
        libva-utils
        lsof
        lurk # A simple and pretty alternative to strace
        mc
        p7zip
        pciutils
        ripgrep
        strace-analyzer
        tmux
        tree
        ugrep
        usbutils
        yazi-unwrapped

      # Storage
        du-dust
        duf
        dysk
        ncdu
    ]);

  pkgsCli = {
    ai = with pkgsUnstable; [
      aichat
      oterm
    ];
    backup = with pkgsUnstable; [
      borgbackup
    ];
    comms = with pkgsUnstable; [
      discordo
      iamb
      weechat
    ];
    cloudNativeTools = with pkgs; [
      awscli2  # Temporarily revert to the stable channel: ⚠ awscli2-2.22.13 failed with exit code 1 after ⏱ 0s in configurePhase
      vagrant  # Should always follow the main channel.
    ] ++ (with pkgsUnstable; [
      argocd
      bootc
      buildah
      cosign
      crc
      distrobox
      eksctl
      k3d
      k9s
      kind
      krew
      kube-bench
      kubecolor
      kubectl
      kubernetes-helm
      kubeswitch
      minikube
      odo  # odo is a CLI tool for fast iterative application development deployed immediately to your kubernetes cluster :: https://odo.dev
      opentofu
      packer
      podman-compose
      podman-tui
      telepresence2
      terraformer
      tf-summarize
      tflint
      tfsec
      tfswitch
    ]);
    multimedia = with pkgsUnstable; [
      exiftool
      imagemagick
      jp2a
      libheif
      mediainfo
      mpv
      pngcrush
      yt-dlp
    ];
    programming = with pkgs; [
    ] ++ (with pkgsUnstable; [
      # Go
        go  # Needed to install individual apps
        # golangci-lint
        # golangci-lint-langserver
        # gopls

      # JS
        # nodejs_latest

      # Python
        uv

      # Rust
        cargo-binstall
        cargo-cache
        chit
        rust-bin.stable.latest.default  # https://github.com/oxalica/rust-overlay
        rustscan

      # Everything else...
        devbox
        gcc
        guix
        mold
        shellcheck
        tokei
        yamlfmt
        zig
    ]);
    security = with pkgsUnstable; [
      age
      chkrootkit
      gpg-tui
      kpcli
      lynis
      mitmproxy
      nikto
      oath-toolkit
      protonvpn-cli
      sops
      vt-cli
    ];
    utilities = with pkgsUnstable; [
      antora
      clinfo
      cmatrix
      dotacat
      fastfetch
      glxinfo
      gum
      nushell
      pipe-rename
      rust-petname
      qrscan
      terminal-parrot
      tesseract
      translate-shell
      tty-clock
      vulkan-tools
      wayland-utils
      wiki-tui
      wl-clipboard
    ];
    vcs = with pkgsUnstable; [
      # Git
        ggshield # GitGuardian
        gh # GitHub CLI client.
        git
        git-lfs
        gitmoji-cli # https://github.com/carloscuesta/gitmoji-cli
        gitty # https://github.com/muesli/gitty/?tab=readme-ov-file
        gitu # It's Gitu! - A Git porcelain outside of Emacs - https://github.com/altsem/gitu
        gitui
        glab # GitLab CLI client.
        # jujutsu
        tig

      # Radicle
        radicle-node
    ];
    web = with pkgsUnstable; [
      elinks
    ];
  };

  pkgsGui =
    with pkgs; [
      # Multimedia
        gimp-with-plugins  # Fails to build from unstable because of some plugins.

      # Security
        keepassxc
        pinentry-qt  # Move to the pkgsUnstable if you're using NixOS from the unstable channel.

      # Utilities
        cool-retro-term  # Let's avoid pulling unnecessary dependencies, as the app last release date was at the end of January 2022.

      # Virtualization
        virt-viewer
    ] ++
    (with pkgsUnstable; [
      # AI
        (lmstudio.override {
          commandLineArgs = [
            "--enable-features=VaapiVideoDecodeLinuxGL"
            "--ignore-gpu-blocklist"
            "--enable-zero-copy"
            "--enable-features=UseOzonePlatform"
            "--ozone-platform=wayland"
          ];
        })

      # Multimedia
        # cinelerra
        # davinci-resolve
        lightworks
        # olive-editor

      # Programming
        neovide
        sublime-merge
        vscode-fhs

      # Security
        # Web
        burpsuite

      # Utilities
        kitty
        wezterm
    ]);

  pkgsGuiShell = {
    # cosmic = with pkgs; [
    # ];
    # hyprland = with pkgs; [
    # ];
      # Virtualization
    kde = with pkgs; [
      kdePackages.alpaka
      kdePackages.discover
      kdePackages.kdenlive
      kdePackages.kio-zeroconf
      kdePackages.kjournald
      kdePackages.krohnkite
      kdePackages.kup
      kdePackages.kwallet-pam
      kdePackages.plasma-browser-integration
      kdePackages.yakuake
      krita
      krita-plugin-gmic

      # Dependencies / helpers
        aha  # Required for "About this System" in System Settings.
        glaxnimate  # Kdenlive dependency
    ];
    # wayfire = with pkgs; [
    # ];
    # xfce = with pkgs; [
    # ];
  };

  pkgsNvidia =
    with pkgs; [
    ] ++
    (with pkgsUnstable; [
      nvtop
    ]);

in {
  options.mySystem = {
    pkgsBaseline = lib.mkOption {
      type = lib.types.enum [ "true" "false" ];
      default = "false";
      description = "Whether to install a baseline set of applications packages";
    };

    pkgsCli = {
      _all = lib.mkOption {  # Collection. Includes the whole set.
        type = lib.types.enum [ "true" "false" ];
        default = "false";
      description = "Whether to install all the CLI applications packages";
      };

      ai = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
      description = "Whether to install CLI related applications packages";
      };

      backup = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
      description = "Whether to install CLI related applications packages";
      };

      comms = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
      description = "Whether to install CLI related applications packages";
      };

      cloudNativeTools = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
      description = "Whether to install CLI related applications packages";
      };

      multimedia = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
      description = "Whether to install CLI related applications packages";
      };

      programming = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
      description = "Whether to install CLI related applications packages";
      };

      security = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
      description = "Whether to install CLI related applications packages";
      };

      utilities = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
      description = "Whether to install CLI related applications packages";
      };

      vcs = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
      description = "Whether to install CLI related applications packages";
      };

      web = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
      description = "Whether to install CLI related applications packages";
      };
    };

    pkgsGui = lib.mkOption {
      type = lib.types.enum [ "true" "false" ];
      default = "false";
      description = "Whether to install GUI applications packages";
    };

    pkgsGuiShell = {
      kde = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
        description = "Whether to install DE/WM complementary applications packages";
      };
    };

    pkgsNvidia = lib.mkOption {  # Set to true if running on an Nvidia host
      type = lib.types.enum [ "true" "false" ];
      default = "false";
      description = "Whether to install Nvidia-releated applications packages";
    };
  };

  config = {
    environment.systemPackages = []  # Start with empty list or your base packages
      ++ (lib.optionals (cfgPkgsBaseline == "true") pkgsBaseline)
      ++ (lib.optionals (cfgPkgsCli_all == "true") (builtins.concatLists (builtins.attrValues pkgsCli)))
      ++ (lib.optionals (cfgPkgsCliAi == "true") pkgsCli.ai)
      ++ (lib.optionals (cfgPkgsCliBackup == "true") pkgsCli.backup)
      ++ (lib.optionals (cfgPkgsCliComms == "true") pkgsCli.comms)
      ++ (lib.optionals (cfgPkgsCliCloudNativeTools == "true") pkgsCli.cloudNativeTools)
      ++ (lib.optionals (cfgPkgsCliMultimedia == "true") pkgsCli.multimedia)
      ++ (lib.optionals (cfgPkgsCliProgramming == "true") pkgsCli.programming)
      ++ (lib.optionals (cfgPkgsCliSecurity == "true") pkgsCli.security)
      ++ (lib.optionals (cfgPkgsCliUtilities == "true") pkgsCli.utilities)
      ++ (lib.optionals (cfgPkgsCliVcs == "true") pkgsCli.vcs)
      ++ (lib.optionals (cfgPkgsCliWeb == "true") pkgsCli.web)
      ++ (lib.optionals (cfgPkgsGui == "true") pkgsGui)
      ++ (lib.optionals (cfgPkgsGuiShellKde == "true") pkgsGuiShell.kde)
      ++ (lib.optionals (cfgPkgsNvidia == "true") pkgsNvidia);

    nixpkgs.config.allowUnfree = true;  # Allow lincense-burdened packages
  };
}


# READ ME!
# =======

# To pin a package to a specific version, use the following syntax:
#  (Your_Package_Name.overrideAttrs (oldAttrs: {
#     src = fetchFromGitHub {
#       owner = "NixOS";
#       repo = "nixpkgs";
#       rev = "the commit hash";
#       hash = "the sha265 hash of the tarball";
#     };
#   }))

# To get the commit hash check the packages repository and look for the package in the correct channel branch, e.g. nixpkgs-unstable:
# https://github.com/NixOS/nixpkgs/blob/nixpkgs-unstable/pkgs/by-name/aw/awscli2/package.nix => https://github.com/NixOS/nixpkgs/commit/62fcc798988975fab297b87345d93919cd6f6389

# To get the sha256 hash of a package, run the following command:
# nix-prefetch-github NixOS nixpkgs --no-deep-clone -v --rev The_Commit_Hash

# Nix-prefetch-github can be installed as a normal package, or invoked on-demand if using `comma` (https://github.com/nix-community/comma, available in the official repositories.
# Of course it can also be installed with `nix-env -iA nixpkgs.nix-prefetch-github`, or temporarily with nix-shell.
