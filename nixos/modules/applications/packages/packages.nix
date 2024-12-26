# This file deines lists and sets of packages to be installed on a host.
# Create as much lists and sets as needed to provide enough flexibility to assemble hosts with different roles.

{ pkgs, unstablePkgs, ... }:

let
  appsBaseline =
    with pkgs; [
      # Nix
        # LSP
          nil
          nixd
        comma
        devpod
        fh # fh, the official FlakeHub CLI :: https://github.com/DeterminateSystems/fh
        hydra-check
        nh
        nickel
        niv
        nix-diff
        nix-index
        nix-tree
        nixfmt-classic
        nixpkgs-fmt
        nixpkgs-review
        rippkgs
        vulnix

      # Python
        python312
        python312Packages.ipython
    ] ++
    (with unstablePkgs; [
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
        bind
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
        atuin
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

  appsGUI =
    with pkgs; [  # Meant to run in a [role]client device, as opposite on a [role]server device.
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

      # Comms
        zoom-us

      # Multimedia
        # cinelerra
        # davinci-resolve
        gimp-with-plugins
        glaxnimate # Kdenlive dependency
        lightworks
        # olive-editor

      # Security
        keepassxc
        pinentry-qt

      # Virtualization
        virt-viewer
    ] ++
    (with unstablePkgs; [
      # Programming
        sublime-merge
        vscode-fhs

      # Security
        # Web
          burpsuite
    ]);

  appsGUIshell = {
    COSMIC = with pkgs; [
    ];
    Hyprland = with pkgs; [
    ];
    KDE = with pkgs; [
        aha  # Required for "About this System" in System Settings.
        kdePackages.alpaka
        kdePackages.discover
        kdePackages.kdenlive
        kdePackages.kio-zeroconf
        kdePackages.kjournald
        kdePackages.krohnkite
        kdePackages.kup
        kdePackages.kwallet-pam
        qtcreator
        kdePackages.plasma-browser-integration
        kdePackages.yakuake
        krita
        krita-plugin-gmic
    ];
    XFCE = with pkgs; [
    ];
  };

  appsNonGUI = {
    ai = with unstablePkgs; [
      aichat
      oterm
    ];
    backup = with unstablePkgs; [
      borgbackup
    ];
    comms = with unstablePkgs; [
      discordo
      iamb
      weechat
    ];
    infrastructure = with unstablePkgs; [
      argocd
      awscli2
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
      # vagrant
    ];
    multimedia = with unstablePkgs; [
      exiftool
      imagemagick
      jp2a
      libheif
      mediainfo
      mpv
      pngcrush
      yt-dlp
    ];
    utilities = with unstablePkgs; [
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
    programming = with unstablePkgs; [
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
    ];
    security = with unstablePkgs; [
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
    vcs = with unstablePkgs; [
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
    web = with unstablePkgs; [
      elinks
    ];
  };

  appsNvidia =
    with pkgs; [
    ] ++
    (with unstablePkgs; [
      nvtop
    ]);
in
{
  lists = {
    appsBaseline = appsBaseline;
    appsGUI = appsGUI;
    appsNonGUI = builtins.concatLists (builtins.attrValues appsNonGUI);  # Flatten entire set; useful when installing everything-and-the-kitchen-sink.
    appsNvidia = appsNvidia;
  };

  sets = {
    appsGUIshell = appsGUIshell;
    appsNonGUI = appsNonGUI;  # Useful when installing only specific concerns.
  };
}