# {}: ''
''
  # Hydra
  hc() {
    # hydra-check example: `hydra-check --arch x86_64-linux --channel unstable starship`
    hydra-check --arch x86_64-linux --channel 24.05 "$1"
  }

  hcs() {
    # hydra-check example: `hydra-check --arch x86_64-linux --channel unstable starship`
    hydra-check --arch x86_64-linux --channel staging "$1"
  }

  hcu() {
    # hydra-check example: `hydra-check --arch x86_64-linux --channel unstable starship`
    hydra-check --arch x86_64-linux --channel unstable "$1"
  }


  # Nix Shell
  # `nix shell` packages from nixpkgs

  nixsh() {
    local p
    for p in "$@"; do
      NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs#$p
    done
  }

  # `nix shell` packages from nixpkgs/nixos-unstable
  nixshu() {
    local p
    for p in "$@"; do
      NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs/nixos-unstable#$p
    done
  }


  # System
  nixcv() {
    local channel_version="$(nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version')"
    echo -e "\n$bold_greenNix channel version: $bold_white$channel_version$reset"
  }
''