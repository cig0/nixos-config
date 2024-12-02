{ pkgs, ... }:

let
  commonPackages = with pkgs; [ # Packages common to all hosts, only from the stable release channel!
    # Comms
      iamb
      weechat

    # IaaS / PaaS / SaaS
      awscli2
      eksctl

    # Infrastructure: CNCF / K8s / OCI / virtualization
      argocd
      cosign
      crc
      distrobox
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

    # Monitoring & Observability
      btop
      glances
      hyperfine
      inxi
      iotop
      lm_sensors
      powertop
      s-tui
      vdpauinfo

    # Multimedia
      glaxnimate # Kdenlive dependency

    # Networking
      aria2
      bind
      dnstracer
      gping # Ping, but with a graph :: https://github.com/orf/gping
      grpcurl
      httpie
      inetutils
      iperf
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

    # Nix
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

    # Programming
      # Go
        go # Needed to install individual apps
        # golangci-lint
        # golangci-lint-langserver
        # gopls

      # JS
        # nodejs_latest

      # Python
        python312
        python312Packages.ipython
        uv

      # Rust
        cargo-binstall
        cargo-cache
        chit

      # Everything else...
        devbox
        gcc
        mold
        shellcheck
        tokei
        yamlfmt
        zig

    # Security
      age
      chkrootkit
      gpg-tui
      kpcli
      lynis
      oath-toolkit
      protonvpn-cli
      rustscan
      sops
      vt-cli

    # Storage
      borgbackup
      du-dust
      duf
      dysk
      ncdu

    # Terminal utilities
      antora
      at
      atuin
      bat
      chezmoi
      clinfo
      cmatrix
      comma
      cyme # https://github.com/tuna-f1sh/cyme :: List system USB buses and devices.
      difftastic
      delta
      dmidecode
      dotacat
      fastfetch
      fd
      fdupes
      file
      fx
      fzf
      getent
      glxinfo
      goaccess
      gum
      joshuto
      jq
      just # https://github.com/casey/just :: A handy way to save and run project-specific commands
      libva-utils
      lsof
      lunarvim
      lurk # A simple and pretty alternative to strace
      mc
      neovim
      nushell
      p7zip
      pciutils
      pipe-rename
      rust-petname
      qrscan
      ripgrep
      strace-analyzer
      terminal-parrot
      tesseract
      tmux
      translate-shell
      tree
      ugrep
      usbutils
      vulkan-tools
      wayland-utils
      wl-clipboard
      xfsprogs
      yazi-unwrapped

    # VCS
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

    # Web
      elinks
  ];

  userSidePackages = with pkgs; [ # Only packages from the stable release channel.
    # Meant to run in a [role]client device, as opposite on a [role]server device.
    # It's preferable to manage KDE applications here to keep them in sync with the base system and avoid pulling the necessary libraries and frameworks

    # KDE
    aha # Required by KDE's About this System
    # amarok
    kdePackages.alpaka
    kdePackages.discover
    kdePackages.kdenlive
    kdePackages.kio-zeroconf
    kdePackages.kjournald
    kdePackages.krohnkite
    qtcreator
    kdePackages.plasma-browser-integration
    kdePackages.yakuake
    krita
    krita-plugin-gmic

    # Security
    pinentry-qt
  ];

in
{
  lists = {
    commonPackages = commonPackages;
    userSidePackages = userSidePackages;
  };
}