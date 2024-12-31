# Don't remove this line! programs.zsh.shellFunctions

{ ... }:

let
  # Description
  functions = ''
    # Hydra
      hc() {  # 'hydra-check' with the `nixos-24.11` channel
        hydra-check --arch x86_64-linux --channel 24.11 "$1"
      }

      hcs() {  # `hydra-check` with the `staging` channel
        hydra-check --arch x86_64-linux --channel staging "$1"
      }

      hcu() {  # `hydra-check` with the `unstable` channel
        hydra-check --arch x86_64-linux --channel unstable "$1"
      }

    # nix-shell
      # `nix shell` packages from nixpkgs
      nixsh() {  # `nix shell` packages from nixpkgs
        local p
        for p in "$@"; do
          NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs#$p
        done
      }

      # `nix shell` packages from nixpkgs/nixos-unstable
      nixshu() {  # `nix shell` packages from nixpkgs/nixos-unstable
        local p
        for p in "$@"; do
          NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs/nixos-unstable#$p
        done
      }

    # System
      nixcv() {  # Outputs the Nix channel version.
        local channel_version="$(nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version')"
        echo -e "\n$bold_greenNix channel version: $bold_white$channel_version$reset"
      }
  '';

in {
  functions = functions;
}