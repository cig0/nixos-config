{ pkgs }:

rec {
  setOptions = [
    # https://superuser.com/questions/519596/share-history-in-multiple-zsh-shell
    # https://unix.stackexchange.com/questions/669971/zsh-can-i-have-a-combined-history-for-all-of-my-shells
    # https://github.com/cig0/Phantas0s-dotfiles/blob/master/zsh/zshrc

    # +------------+
    # | NAVIGATION |
    # +------------+
    "AUTO_CD"
    "AUTO_PUSHD"
    "PUSHD_IGNORE_DUPS"
    "PUSHD_SILENT"
    "CORRECT"
    "CDABLE_VARS"

    # +---------+
    # | HISTORY |
    # +---------+
    "EXTENDED_HISTORY"
    "SHARE_HISTORY"
    "HIST_EXPIRE_DUPS_FIRST"
    "HIST_IGNORE_DUPS"
    "HIST_IGNORE_ALL_DUPS"
    "HIST_FIND_NO_DUPS"
    "HIST_IGNORE_SPACE"
    "HIST_SAVE_NO_DUPS"
    "HIST_VERIFY"
  ];


  interactiveShellInit = ''
    # Needs https://github.com/nix-community/nix-index
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh

    # ANSI escape codes for colors
    local bold_green="\e[1;32m"
    local bold_white="\e[1;97m"
    # ANSI escape code for resetting text attributes
    local reset="\e[0m"


    # Needs https://github.com/nix-community/nix-index
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh


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
  '';


  loginShellInit = interactiveShellInit;


  shellInit = ''
    # Preferred editor for local and remote sessions
    if [[ -n $SSH_CONNECTION ]]; then
      export EDITOR='vim'
    else
      export EDITOR='lvim'
    fi
  '';


  # Oh My Zsh Plugins
  ohMyZsh = {
    plugins = [ "fzf" "history-substring-search" ];
  };


  shellAliases = {
    # Cleaning
    nhc = "nh clean all --keep 3";
    nixc = "nix-collect-garbage -d 3";

    # Searching
    nixse = "nix search nixpkgs";
    nixseu = "nix search nixpkgs/nixos-unstable#";
    nhs = "nh search";

    # System
    nixinfo = "nix-info --host-os -m";
    nixlg = "nixos-rebuild list-generations";
  };
}