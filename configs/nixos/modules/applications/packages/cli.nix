# @MODULON_SKIP
# Set of packages for all hosts
# This file is extracted from packages.nix to improve modularity and maintainability.
{ pkgs, pkgs-unstable, ... }:
{
  ai = with pkgs-unstable; [
    aichat
    # oterm
  ];

  backup = with pkgs-unstable; [ borgbackup ];

  comms = with pkgs-unstable; [
    syncterm # BBS terminal emulator :: Homepage: https://syncterm.bbsdev.net/
  ];

  cloudNativeTools =
    with pkgs;
    [
      vagrant # Should always follow the main channel.
    ]
    ++ (with pkgs-unstable; [
      # argocd
      awscli2 # Unified tool to manage your AWS services :: https://aws.amazon.com/cli/
      bootc
      buildah
      # cosign
      crc
      ctop
      distrobox
      dive
      # eksctl
      # k3d
      # k9s
      # kind
      # krew
      # kubectl
      # kubernetes-helm
      lazydocker
      # packer # Tool for creating identical machine images for multiple platforms from a single source configuration :: https://www.packer.io
      podlet # Generate Podman Quadlet files from a Podman command, compose file, or existing object :: https://github.com/containers/podlet
      podman-compose
      podman-tui
    ]);

  databases = with pkgs-unstable; [ ];

  # WIP: properly categorize `misc` packages
  misc = with pkgs-unstable; [
    antora # Modular documentation site generator. Designed for users of Asciidoctor :: https://antora.org
    asciinema # Terminal session recorder and the best companion of asciinema.org :: https://asciinema.org/
    clinfo
    cmatrix
    dotacat
    fastfetch
    genact # Nonsense activity generator :: https://github.com/svenstaro/genact
    glxinfo
    hollywood # Fill your console with Hollywood melodrama technobabble :: https://a.hollywood.computer
    k6 # A modern load testing tool, using Go and JavaScript :: https://github.com/grafana/k6
    ntfs3g
    nms # A command line tool that recreates the famous data decryption effect seen in the 1992 movie Sneakers :: https://github.com/bartobri/no-more-secrets
    qrscan
    rust-petname
    pipe-rename
    terminal-parrot
    tesseract
    translate-shell
    tty-clock
    vulkan-tools
    wayland-utils
    wiki-tui
    wl-clipboard
  ];

  multimedia = with pkgs-unstable; [
    exiftool
    ffmpeg # Complete, cross-platform solution to record, convert and stream audio and video :: https://ffmpeg.org [Yazi's requirement: https://yazi-rs.github.io/docs/installation/]
    imagemagick # Software suite to create, edit, compose, or convert bitmap images :: https://imagemagick.org
    jp2a
    mediainfo
    mpv
    pngcrush
    yt-dlp
  ];

  networking =
    with pkgs;
    [ ]
    ++ (with pkgs-unstable; [
      openconnect_openssl
    ]);

  programming =
    with pkgs;
    [ ]
    ++ (with pkgs-unstable; [
      # API
      atac # A simple API client (Postman-like) in your terminal :: https://github.com/Julien-cpsn/ATAC

      # Bash / Zsh
      shellcheck

      # Go
      go
      # golangci-lint
      # golangci-lint-langserver
      # gopls

      # JS
      # nodejs_latest

      # Python
      ruff
      uv

      # Rust
      cargo-binstall
      cargo-cache
      # chit # A tool for looking up details about rust crates without going to crates.io :: https://github.com/peterheesterman/chit

      # YAML
      yamlfmt

      # Everything else...
      tokei
    ]);

  secrets = with pkgs-unstable; [
    age # https://github.com/FiloSottile/age/discussions/231
    agebox
    gpg-tui
    sops
  ];

  security =
    with pkgs;
    [ mitmproxy ]
    ++ (with pkgs-unstable; [
      chkrootkit
      lynis
      netscanner # Network scanner with features like WiFi scanning, packetdump and more :: https://github.com/Chleba/netscanner
      nikto
      oath-toolkit
      protonvpn-cli
      sbctl # Secure boot
      vt-cli
    ]);

  vcs = with pkgs-unstable; [
    # Git
    ggshield # GitGuardian
    git-crypt # Transparent file encryption in git :: https://www.agwa.name/projects/git-crypt
    git-filter-repo # Quickly rewrite git repository history :: https://github.com/newren/git-filter-repo
    gitmoji-cli # https://github.com/carloscuesta/gitmoji-cli
    # glab # GitLab CLI client
    lefthook

    # GitHub
    gh # GitHub CLI client
    # Actions
    act # Run your GitHub Actions locally :: https://github.com/nektos/act
    actionlint # Static checker for GitHub Actions workflow files :: https://rhysd.github.io/actionlint/
    pinact # Pin GitHub Actions versions :: https://github.com/suzuki-shunsuke/pinact
    zizmor # Tool for finding security issues in GitHub Actions setups :: https://woodruffw.github.io/zizmor/

    # Jujutsu
    lazyjj
    jjui
    jujutsu
  ];

  web = with pkgs-unstable; [
    elinks
    w3m-nox
  ];
}
