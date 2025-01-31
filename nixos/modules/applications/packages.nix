{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  ...
}: let
  cfg = config.mySystem.packages;

  packagesBaseline = with pkgs;
    [
      # Networking
      httping # Ping with HTTP requests :: https://vanheusden.com/httping

      # Nix
      # LSP
      nil
      nixd
      alejandra # The Uncompromising Nix Code Formatter :: https://github.com/kamadorueda/alejandra
      comma
      devpod
      fh # fh, the official FlakeHub CLI :: https://github.com/DeterminateSystems/fh
      fuse3
      hydra-check
      manix
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
    ]
    ++ (with pkgsUnstable; [
      # Misc
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
      gum
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
      doggo
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
      rust-petname
      pipe-rename
      prettyping # prettyping is a wrapper around the standard ping tool, making the output prettier, more colorful, more compact, and easier to read :: https://github.com/deniconfig, lib,lsonsa/prettyping
      socat
      sshfs-fuse
      tcpdump
      traceroute
      wavemon
      whois

      # Storage
      du-dust
      duf
      dysk
      ncdu
    ]);

  packagesCli = {
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
    cloudNativeTools = with pkgs;
      [
        awscli2 # Temporarily revert to the stable channel: ⚠ awscli2-2.22.13 failed with exit code 1 after ⏱ 0s in configurePhase
        vagrant # Should always follow the main channel.
      ]
      ++ (with pkgsUnstable; [
        aiac # Artificial Intelligence Infrastructure-as-Code Generator :: https://github.com/gofireflyio/aiac/
        argocd
        bootc
        buildah
        cosign
        crc
        ctop
        distrobox
        dive
        eksctl
        k3d
        k9s
        kdash
        kind
        krew
        kube-bench
        kubecolor
        kubectl
        kubernetes-helm
        kubescape
        kubeswitch
        lazydocker
        minikube
        odo # odo is a CLI tool for fast iterative application development deployed immediately to your kubernetes cluster :: https://odo.dev
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
    programming = with pkgs;
      [
      ]
      ++ (with pkgsUnstable; [
        # Go
        go # Needed to install individual apps
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
        rust-bin.stable.latest.default # https://github.com/oxalica/rust-overlay
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
    misc = with pkgsUnstable; [
      antora
      asciinema # Terminal session recorder and the best companion of asciinema.org :: https://asciinema.org/
      atac # A simple API client (Postman-like) in your terminal :: https://github.com/Julien-cpsn/ATAC
      clinfo
      cmatrix
      dotacat
      fastfetch
      genact # Nonsense activity generator :: https://github.com/svenstaro/genact
      glxinfo
      hollywood # Fill your console with Hollywood melodrama technobabble :: https://a.hollywood.computer
      k6 # A modern load testing tool, using Go and JavaScript :: https://github.com/grafana/k6
      nms # A command line tool that recreates the famous data decryption effect seen in the 1992 movie Sneakers :: https://github.com/bartobri/no-more-secrets
      nushell
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
      git-crypt
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

  packagesGui = with pkgs;
    [
      # Misc
      cool-retro-term # Let's avoid pulling unnecessary dependencies, as the app last release date was at the end of January 2022.

      # Multimedia
      gimp-with-plugins # Fails to build from unstable because of some plugins.

      # Security
      keepassxc
      pinentry-qt # Move to the pkgsUnstable if you're using NixOS from the unstable channel.

      # Virtualization
      virt-viewer
    ]
    ++ (with pkgsUnstable; [
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

      # Misc
      kitty
      warp-terminal
      waveterm
      wezterm

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
    ]);

  packagesGuiShell = {
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
      aha # Required for "About this System" in System Settings.
      glaxnimate # Kdenlive dependency
    ];
    # wayfire = with pkgs; [
    # ];
    # xfce = with pkgs; [
    # ];
  };

  packagesNvidia = with pkgs;
    [
    ]
    ++ (with pkgsUnstable; [
      nvtop
    ]);
in {
  options.mySystem = {
    packages = {
      baseline = lib.mkEnableOption "Whether to install a baseline set of applications packages.";
      cli = {
        _all = lib.mkEnableOption "Whether to install all the CLI applications packages.";
        ai = lib.mkEnableOption "Whether to install CLI related applications packages.";
        backup = lib.mkEnableOption "Whether to install CLI related applications packages.";
        cloudNativeTools = lib.mkEnableOption "Whether to install CLI related applications packages.";
        comms = lib.mkEnableOption "Whether to install CLI related applications packages.";
        misc = lib.mkEnableOption "Whether to install CLI related applications packages.";
        multimedia = lib.mkEnableOption "Whether to install CLI related applications packages.";
        programming = lib.mkEnableOption "Whether to install CLI related applications packages.";
        security = lib.mkEnableOption "Whether to install CLI related applications packages.";
        vcs = lib.mkEnableOption "Whether to install CLI related applications packages.";
        web = lib.mkEnableOption "Whether to install CLI related applications packages.";
      };
      gui = lib.mkEnableOption "Whether to install GUI applications packages.";
      guiShell = {
        kde = lib.mkEnableOption "Whether to install DE/WM complementary applications packages.";
      };
      nvidia = lib.mkEnableOption "Whether to install Nvidia-releated applications packages.";
    };
  };

  config = {
    environment.systemPackages =
      [] # Start with empty list or your base packages
      ++ (lib.optionals (cfg.baseline == true) packagesBaseline)
      ++ (lib.optionals (cfg.cli._all == true) (builtins.concatLists (builtins.attrValues packagesCli)))
      ++ (lib.optionals (cfg.cli.ai == true) packagesCli.ai)
      ++ (lib.optionals (cfg.cli.backup == true) packagesCli.backup)
      ++ (lib.optionals (cfg.cli.comms == true) packagesCli.comms)
      ++ (lib.optionals (cfg.cli.cloudNativeTools == true) packagesCli.cloudNativeTools)
      ++ (lib.optionals (cfg.cli.misc == true) packagesCli.misc)
      ++ (lib.optionals (cfg.cli.multimedia == true) packagesCli.multimedia)
      ++ (lib.optionals (cfg.cli.programming == true) packagesCli.programming)
      ++ (lib.optionals (cfg.cli.security == true) packagesCli.security)
      ++ (lib.optionals (cfg.cli.vcs == true) packagesCli.vcs)
      ++ (lib.optionals (cfg.cli.web == true) packagesCli.web)
      ++ (lib.optionals (cfg.gui == true) packagesGui)
      ++ (lib.optionals (cfg.guiShell.kde == true) packagesGuiShell.kde)
      ++ (lib.optionals (cfg.nvidia == true) packagesNvidia);

    nixpkgs.config.allowUnfree = true; # Allow lincense-burdened packages
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

