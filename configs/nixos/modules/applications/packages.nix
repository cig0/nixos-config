# TODO: polish up the packages lists in a way that makes it easier to maintain and update them for their roles. packagesBaseline is becoming an everything-and-the-kitchen-sink list.

{
  config,
  inputs,
  lib,
  pkgs,
  system,
  ...
}:
let
  cfg = config.mySystem.packages;

  packagesBaseline =
    with pkgs;
    [
      # Nix - Security
      vulnix # NixOS vulnerability scanner :: https://github.com/nix-community/vulnix

      # Networking
      httping # Ping with HTTP requests :: https://vanheusden.com/httping

      # Python
      python312 # High-level dynamically-typed programming language :: https://www.python.org
      python312Packages.ipython # IPython: Productive Interactive Computing :: https://ipython.org/

      # Storage
      nfstrace # NFS and CIFS tracing/monitoring/capturing/analyzing tool :: NFS and CIFS tracing/monitoring/capturing/analyzing tool
    ]
    ++ (with pkgsUnstable; [
      # Misc
      at
      bat
      broot
      chezmoi
      cyme # https://github.com/tuna-f1sh/cyme :: List system USB buses and devices.
      difftastic
      delta
      direnv
      dmidecode
      fd # Simple, fast and user-friendly alternative to find :: https://github.com/sharkdp/fd [Yazi's requirement: https://yazi-rs.github.io/docs/installation/]
      fdupes
      file
      fx # Terminal JSON viewer :: https://github.com/antonmedv/fx
      fzf # Command-line fuzzy finder written in Go :: https://github.com/junegunn/fzf [Yazi's requirement: https://yazi-rs.github.io/docs/installation/]
      getent
      goaccess
      gum
      jq
      just # https://github.com/casey/just :: A handy way to save and run project-specific commands
      libva-utils
      lsof
      lurk # A simple and pretty alternative to strace
      mc
      p7zip
      pciutils
      poppler # PDF rendering library :: [Yazi's requirement: https://yazi-rs.github.io/docs/installation/]
      ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep :: https://github.com/BurntSushi/ripgrep [Yazi's requirement: https://yazi-rs.github.io/docs/installation/]
      strace-analyzer
      tmux
      tree
      ugrep
      usbutils
      yq-go # Portable command-line YAML processor :: https://mikefarah.gitbook.io/yq/
      zoxide # Fast cd command that learns your habits :: https://github.com/ajeetdsouza/zoxide

      # Monitoring & Observability
      btop
      hyperfine
      inxi
      iotop
      lm_sensors
      s-tui

      # Networking
      aria2
      baddns # Check subdomains for subdomain takeovers and other DNS tomfoolery :: https://github.com/blacklanternsecurity/baddns
      dnstracer
      doggo # Command-line DNS Client for Humans. Written in Golang. :: https://github.com/mr-karan/doggo
      gping # Ping, but with a graph :: https://github.com/orf/gping
      grpcurl
      httpie
      inetutils
      iperf
      iw
      lftp
      nmap
      ookla-speedtest
      rustscan # Faster Nmap Scanning with Rust :: https://github.com/RustScan/RustScan
      prettyping # prettyping is a wrapper around the standard ping tool, making the output prettier, more colorful, more compact, and easier to read :: https://github.com/deniconfig, lib,lsonsa/prettyping
      socat
      sshfs-fuse
      tcpdump
      traceroute
      wavemon
      whois
      xh # Friendly and fast tool for sending HTTP requests :: https://github.com/ducaale/xh

      # Nix
      comma # Runs programs without installing them :: https://github.com/nix-community/comma
      fh # fh, the official FlakeHub CLI :: https://github.com/DeterminateSystems/fh
      hydra-check # Check hydra for the build status of a package :: https://github.com/nix-community/hydra-check
      manix # Fast CLI documentation searcher for Nix options :: https://github.com/nix-community/manix
      nickel # Better configuration for less :: https://nickel-lang.org/
      niv # Easy dependency management for Nix projects :: https://hackage.haskell.org/package/niv
      nix-diff # Explain why two Nix derivations differ :: https://github.com/nix-community/nix-index
      nix-index # Files database for nixpkgs :: https://github.com/nix-community/nix-index
      nix-melt # Ranger-like flake.lock viewer :: https://github.com/nix-community/nix-melt
      nix-tree # Interactively browse a Nix store paths dependencies :: https://hackage.haskell.org/package/nix-tree
      nixfmt-rfc-style # Official formatter for Nix code :: https://github.com/NixOS/nixfmt
      nixpkgs-review # Review pull-requests on https://github.com/NixOS/nixpkgs :: https://github.com/Mic92/nixpkgs-review
      nvd # Nix/NixOS package version diff tool :: https://khumba.net/projects/nvd
      # Nix - Development Environments
      devbox # Instant, easy, predictable shells and containers :: https://www.jetpack.io/devbox
      devenv # Fast, Declarative, Reproducible, and Composable Developer Environments :: https://github.com/cachix/devenv
      # Nix - LSP
      nil # Yet another language server for Nix :: https://github.com/oxalica/nil
      # nixd # Feature-rich Nix language server interoperating with C++ nix :: https://github.com/nix-community/nixd

      # Storage
      du-dust
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
    comms = with pkgsUnstable; [ ];
    cloudNativeTools =
      with pkgs;
      [
        vagrant # Should always follow the main channel.
      ]
      ++ (with pkgsUnstable; [
        aiac # Artificial Intelligence Infrastructure-as-Code Generator :: https://github.com/gofireflyio/aiac/
        argocd
        awscli2 # Unified tool to manage your AWS services :: https://aws.amazon.com/cli/
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
        podlet # Generate Podman Quadlet files from a Podman command, compose file, or existing object :: https://github.com/containers/podlet
        podman-compose
        podman-tui
        pulumi # Pulumi is a cloud development platform that makes creating cloud programs easy and productive :: https://pulumi.io/
        pulumi-esc # Pulumi ESC (Environments, Secrets, and Configuration) for cloud applications and infrastructure :: https://github.com/pulumi/esc/tree/main
        pulumictl # Swiss Army Knife for Pulumi Development :: https://github.com/pulumi/pulumictl
        pulumiPackages.pulumi-aws-native
        pulumiPackages.pulumi-language-python
        pulumiPackages.pulumi-random
        telepresence2
        terraformer
        tf-summarize
        tflint
        tfsec
        tfswitch
      ]);
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
      helix
      hollywood # Fill your console with Hollywood melodrama technobabble :: https://a.hollywood.computer
      k6 # A modern load testing tool, using Go and JavaScript :: https://github.com/grafana/k6
      nms # A command line tool that recreates the famous data decryption effect seen in the 1992 movie Sneakers :: https://github.com/bartobri/no-more-secrets
      qrscan
      rust-petname
      pipe-rename
      syncterm # BBS terminal emulator :: Homepage: https://syncterm.bbsdev.net/
      terminal-parrot
      tesseract
      translate-shell
      tty-clock
      vulkan-tools
      wayland-utils
      wiki-tui
      wl-clipboard
    ];
    multimedia = with pkgsUnstable; [
      exiftool
      ffmpeg # Complete, cross-platform solution to record, convert and stream audio and video :: https://ffmpeg.org [Yazi's requirement: https://yazi-rs.github.io/docs/installation/]
      imagemagick # Software suite to create, edit, compose, or convert bitmap images :: https://imagemagick.org
      jp2a
      libheif
      mediainfo
      mpv
      pngcrush
      yt-dlp
    ];
    programming =
      with pkgs;
      [
      ]
      ++ (with pkgsUnstable; [
        devpod # Codespaces but open-source, client-only and unopinionated: Works with any IDE and lets you use any cloud, kubernetes or just localhost docker :: https://devpod.sh

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

        # Everything else...
        gcc
        guix
        mold
        shellcheck
        tokei
        yamlfmt
        zig
      ]);
    security =
      with pkgs;
      [
        mitmproxy
      ]
      ++ (with pkgsUnstable; [
        age
        chkrootkit
        gpg-tui
        kpcli
        lynis
        nikto
        oath-toolkit
        protonvpn-cli
        sops
        vt-cli
      ]);
    vcs = with pkgsUnstable; [
      # Git
      ggshield # GitGuardian
      gh # GitHub CLI client.
      git-crypt
      gitmoji-cli # https://github.com/carloscuesta/gitmoji-cli
      gitty # https://github.com/muesli/gitty/?tab=readme-ov-file
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

  packagesGui =
    with pkgs;
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

  packagesNvidia =
    with pkgs;
    [
    ]
    ++ (with pkgsUnstable; [
      nvtop
    ]);

  # Leverage NixOS might by allowing to mix packages from both the stable and unstable release channels
  pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  options.mySystem = {
    lib = {
      # Create a flattened list of packages to install contributed by modules
      modulePackages = lib.mkOption {
        type = with lib.types; listOf package;
        default = [ ];
        description = "List of packages contributed by modules";
        apply = x: lib.flatten x; # This ensures nested lists are flattened
        internal = true;
      };
    };
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
      [ ] # Start with an empty list or your base packages
      ++ lib.optionals cfg.baseline packagesBaseline
      ++ lib.optionals cfg.cli._all (builtins.concatLists (builtins.attrValues packagesCli))
      ++ lib.optionals cfg.cli.ai packagesCli.ai
      ++ lib.optionals cfg.cli.backup packagesCli.backup
      ++ lib.optionals cfg.cli.comms packagesCli.comms
      ++ lib.optionals cfg.cli.cloudNativeTools packagesCli.cloudNativeTools
      ++ lib.optionals cfg.cli.misc packagesCli.misc
      ++ lib.optionals cfg.cli.multimedia packagesCli.multimedia
      ++ lib.optionals cfg.cli.programming packagesCli.programming
      ++ lib.optionals cfg.cli.security packagesCli.security
      ++ lib.optionals cfg.cli.vcs packagesCli.vcs
      ++ lib.optionals cfg.cli.web packagesCli.web
      ++ lib.optionals cfg.gui packagesGui
      ++ lib.optionals cfg.guiShell.kde packagesGuiShell.kde
      ++ lib.optionals cfg.nvidia packagesNvidia
      ++ config.mySystem.lib.modulePackages; # Add module-contributed packages

    nixpkgs.config.allowUnfree = true; # Allow lincense-burdened packages
    _module.args = {
      pkgsUnstable = pkgsUnstable; # Expose the unstable channel to modules
    };
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
