# @MODULON_SKIP
# Baseline set of packages for all hosts
# This file is extracted from packages.nix to improve modularity and maintainability.
{ pkgs, pkgs-unstable, ... }:
with pkgs;
[
  # Nix
  vulnix # NixOS vulnerability scanner :: https://github.com/nix-community/vulnix

  # Networking
  httping # Ping with HTTP requests :: https://vanheusden.com/httping

  # Python
  python313 # High-level dynamically-typed programming language :: https://www.python.org
  python313Packages.ipython # IPython: Productive Interactive Computing :: https://ipython.org/

  # Storage
  # nfstrace # TODO: build failing. NFS and CIFS tracing/monitoring/capturing/analyzing tool :: NFS and CIFS tracing/monitoring/capturing/analyzing tool
] ++ (with pkgs-unstable; [
  # Misc
  at
  broot # Interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands :: https://dystroy.org/broot/
  chezmoi
  cyme # https://github.com/tuna-f1sh/cyme :: List system USB buses and devices.
  delta
  difftastic
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
  prettyping # prettyping is a wrapper around the standard ping tool, making the output prettier, more colorful, more compact, and easier to read :: https://github.com/denisonsa/prettyping
  socat
  sshfs-fuse
  tcpdump
  traceroute
  wavemon
  whois
  xh # Friendly and fast tool for sending HTTP requests (httpie/curl alternative) :: https://github.com/ducaale/xh

  # Nix
  comma # Runs programs without installing them :: https://github.com/nix-community/comma
  fh # fh, the official FlakeHub CLI :: https://github.com/DeterminateSystems/fh
  hydra-check # Check hydra for the build status of a package :: https://github.com/nix-community/hydra-check
  manix # Fast CLI documentation searcher for Nix options :: https://github.com/nix-community/manix
  nickel # Better configuration for less :: https://nickel-lang.org/
  niv # Easy dependency management for Nix projects :: https://hackage.haskell.org/package/niv
  nix-diff # Explain why two Nix derivations differ :: https://github.com/nix-community/nix-index
  nix-init # Command line tool to generate Nix packages from URLs :: https://github.com/nix-community/nix-init
  nix-melt # Ranger-like flake.lock viewer :: https://github.com/nix-community/nix-melt
  nix-prefetch-github # Prefetch sources from github :: https://github.com/seppeljordan/nix-prefetch-github
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
])
