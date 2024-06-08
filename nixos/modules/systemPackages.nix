{ config, pkgs, unstablePkgs, ... }:

let
  commonPackages = [ # packages common to all hosts
    # Git
    unstablePkgs.ggshield
    unstablePkgs.gh # GitHub CLI client.
                    # https://github.com
    unstablePkgs.git
    unstablePkgs.git-lfs
    unstablePkgs.gitui
    unstablePkgs.glab # GitLab CLI client.
                      # https://gitlab.com
    unstablePkgs.jujutsu
    unstablePkgs.tig

    # IaaS / PaaS / SaaS
    unstablePkgs.awscli2
    unstablePkgs.eksctl

    # Infrastructure: CNCF / K8s / OCI / virtualization
    unstablePkgs.argocd
    unstablePkgs.boxbuddy
    unstablePkgs.cosign
    unstablePkgs.crc
    unstablePkgs.distrobox
    unstablePkgs.k3d
    unstablePkgs.k9s
    unstablePkgs.kind
    unstablePkgs.krew
    unstablePkgs.kube-bench
    unstablePkgs.kubecolor
    unstablePkgs.kubectl
    unstablePkgs.kubernetes-helm
    unstablePkgs.kubeswitch
    unstablePkgs.minikube
    unstablePkgs.odo # odo is a CLI tool for fast iterative application development deployed immediately to your kubernetes cluster.
                     # https://odo.dev
    unstablePkgs.opentofu
    unstablePkgs.packer
    unstablePkgs.podman-compose
    unstablePkgs.podman-tui
    unstablePkgs.telepresence2
    unstablePkgs.terraformer
    unstablePkgs.tf-summarize
    unstablePkgs.tflint
    unstablePkgs.tfsec
    unstablePkgs.tfswitch
    unstablePkgs.vagrant
    # Virtualization
      unstablePkgs.OVMF

    # Monitoring & Observability
    unstablePkgs.btop
    unstablePkgs.glances
    unstablePkgs.hyperfine
    unstablePkgs.inxi
    unstablePkgs.iotop
    unstablePkgs.lm_sensors
    unstablePkgs.powertop
    unstablePkgs.s-tui
    unstablePkgs.vdpauinfo

    # Networking
    unstablePkgs.aria2
    unstablePkgs.dig
    unstablePkgs.dnstracer
    unstablePkgs.gping # Ping, but with a graph.
                       # https://github.com/orf/gping
    unstablePkgs.grpcurl
    unstablePkgs.httpie
    unstablePkgs.inetutils
    unstablePkgs.iperf
    unstablePkgs.lftp
    unstablePkgs.nfstrace
    unstablePkgs.nmap
    unstablePkgs.ookla-speedtest
    unstablePkgs.prettyping # prettyping is a wrapper around the standard ping tool, making the output prettier, more colorful, more compact, and easier to read.
                            # https://github.com/denilsonsa/prettyping
    unstablePkgs.socat
    unstablePkgs.sshfs-fuse
    unstablePkgs.tcpdump
    unstablePkgs.traceroute
    unstablePkgs.whois

    # Nix
    unstablePkgs.devpod
    unstablePkgs.fh # fh, the official FlakeHub CLI
                    # https://github.com/DeterminateSystems/fh
    unstablePkgs.hydra-check
    unstablePkgs.nh
    unstablePkgs.niv
    unstablePkgs.nix-index
    unstablePkgs.nix-tree
    unstablePkgs.nixfmt-classic
    unstablePkgs.nixpkgs-fmt
    unstablePkgs.nixpkgs-review
    unstablePkgs.rippkgs
    unstablePkgs.vulnix

    # Programming - CLI
      # Go
      unstablePkgs.go # Needed to install individual apps
      # golangci-lint
      # golangci-lint-langserver
      # gopls

      # JS
      # nodejs_latest

      # Nickel
      unstablePkgs.nickel

      # Python
      unstablePkgs.python312Full
      unstablePkgs.python312Packages.ipython
      # uv

      # Everything else...
      unstablePkgs.devbox
      unstablePkgs.gcc
      unstablePkgs.mold
      unstablePkgs.tokei
      unstablePkgs.yamlfmt

    # Security - CLI
    unstablePkgs.age
    unstablePkgs.chkrootkit
    unstablePkgs.gpg-tui
    unstablePkgs.lynis
    unstablePkgs.oath-toolkit
    unstablePkgs.protonvpn-gui
    unstablePkgs.rustscan
    unstablePkgs.sops
    unstablePkgs.vt-cli

    # Storage - CLI
    unstablePkgs.du-dust
    unstablePkgs.duf
    unstablePkgs.dysk
    unstablePkgs.ncdu

    # # Terminal utilities
    unstablePkgs.antora
    unstablePkgs.at
    unstablePkgs.atuin
    unstablePkgs.bat
    unstablePkgs.chezmoi
    unstablePkgs.clinfo
    unstablePkgs.cmatrix
    unstablePkgs.comma
    unstablePkgs.difftastic
    unstablePkgs.delta
    unstablePkgs.dmidecode
    unstablePkgs.dotacat
    unstablePkgs.fastfetch
    unstablePkgs.fd
    unstablePkgs.fdupes
    unstablePkgs.file
    unstablePkgs.fx
    unstablePkgs.fzf
    unstablePkgs.getent
    unstablePkgs.glxinfo
    unstablePkgs.goaccess
    unstablePkgs.gum
    unstablePkgs.joshuto
    unstablePkgs.jq
    unstablePkgs.just # https://github.com/casey/just :: A handy way to save and run project-specific commands
    unstablePkgs.libva-utils
    unstablePkgs.lsof
    unstablePkgs.lunarvim
    unstablePkgs.lurk # A simple and pretty alternative to strace
    unstablePkgs.mc
    unstablePkgs.nushell
    unstablePkgs.osquery
    unstablePkgs.p7zip
    unstablePkgs.pciutils
    unstablePkgs.pinentry-curses
    unstablePkgs.qrscan
    unstablePkgs.ripgrep
    unstablePkgs.strace
    unstablePkgs.strace-analyzer
    unstablePkgs.tesseract
    unstablePkgs.translate-shell
    unstablePkgs.tree
    unstablePkgs.ugrep
    unstablePkgs.vulkan-tools
    unstablePkgs.wayland-utils
    unstablePkgs.wl-clipboard
    unstablePkgs.zola
  ];

  endUserPackages = [ # meant to run by a human user
    # AI
    unstablePkgs.aichat
    unstablePkgs.lmstudio
    unstablePkgs.oterm

    # Comms
    unstablePkgs.discordo
    unstablePkgs.element-desktop-wayland
    unstablePkgs.shortwave
    unstablePkgs.telegram-desktop
    unstablePkgs.weechat
    unstablePkgs.zoom-us

    # Infrastructure: CNCF / K8s / OCI / virtualization
    unstablePkgs.openlens
    unstablePkgs.podman-desktop

    # Games
    unstablePkgs.naev

    # GNOME
    # gnomeExtensions.appindicator

    # KDE
    unstablePkgs.aha # Required by KDE's About this System
    # amarok
    unstablePkgs.kdePackages.alpaka
    unstablePkgs.kdePackages.discover
    unstablePkgs.kdePackages.kio-zeroconf
    unstablePkgs.kdePackages.kjournald
    unstablePkgs.qtcreator
    pkgs.kdePackages.plasma-browser-integration
    unstablePkgs.kdePackages.yakuake

    # Multimedia
    unstablePkgs.blender
    unstablePkgs.darktable
    unstablePkgs.exiftool
    unstablePkgs.gimp
    unstablePkgs.imagemagick
    unstablePkgs.inkscape
    unstablePkgs.jp2a
    unstablePkgs.libheif
    unstablePkgs.mediainfo
    unstablePkgs.mpv
    unstablePkgs.nicotine-plus
    unstablePkgs.pngcrush
    unstablePkgs.shortwave
    unstablePkgs.yt-dlp

    # Networking - GUI
    unstablePkgs.wireshark-qt

    # Productivity
    unstablePkgs.obsidian
    unstablePkgs.todoist-electron

    # Programming - GUI
    unstablePkgs.imhex
    unstablePkgs.sublime-merge
    unstablePkgs.sublime4
    unstablePkgs.vscode-fhs

    # Security - GUI
    unstablePkgs.bitwarden
    unstablePkgs.keepassxc

    # Storage - GUI
    unstablePkgs.borgbackup
    unstablePkgs.vorta

    # Terminal utilities - GUI
    unstablePkgs.warp-terminal

    # Virtualization - GUI
    unstablePkgs.virt-viewer

    # Web
    unstablePkgs.ungoogled-chromium
    unstablePkgs.tor-browser
    # (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})

    # Everything else
    unstablePkgs.wiki-tui
  ];

  systemPackages =
    if config.networking.hostName == "perrrkele" then
      let perrrkelePackages = commonPackages ++ endUserPackages;
      in perrrkelePackages

    else if config.networking.hostName == "satama" then
      let satamaPackages = commonPackages ++ [ pkgs.cockpit ];
      in satamaPackages

    else if config.networking.hostName == "vittusaatana" then
      let vittusaatanaPackages = commonPackages ++ endUserPackages ++ [ pkgs.nvtop ];
      in vittusaatanaPackages

    else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";
in
  {
    imports = [
      # ./systemPackages-overrides.nix
    ];

    # ===== Packages to exclude =====
    ## GNOME Desktop
    environment.gnome.excludePackages = (with pkgs; [ # for packages that are pkgs.***
      gnome-tour
      gnome-connections
        ]) ++ (with pkgs.gnome; [ # for packages that are pkgs.gnome.***
        epiphany # web browser
        geary # email reader
        evince # document viewer
    ]);

    # Allow lincense-burdened packages
    nixpkgs.config = {
      allowUnfree = true;
    };

    # Install system packages based on the determined host list
    environment.systemPackages = systemPackages;
  }
