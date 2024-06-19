# TODO:
#   - Split interactiveShellInit
#   - Split shellAliases

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

    # Nix and NixOS
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

      # Shell
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

    # Uncomment the following line to display red dots whilst waiting for completion.
    # You can also set it to another string to have that shown instead of the default red dots.
    # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
    # Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
    COMPLETION_WAITING_DOTS="true"

    # Uncomment the following line if you want to change the command execution time
    # stamp shown in the history command output.
    # You can set one of the optional three formats:
    # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
    # or set a custom format using the strftime function format specifications,
    # see 'man strftime' for details.
    # HIST_STAMPS="mm/dd/yyyy"
    HIST_STAMPS="yyyy-mm-dd"

    # Shell editing Emacs' style
    bindkey -e

    # zsh_reload
    zr() {
      if [ -n "$(jobs)" ]; then
        print -P "Error: %j job(s) in background"
      else
        [[ -n "$ORIGINAL_PATH" ]] && export PATH="$ORIGINAL_PATH"
        exec zsh
      fi
    }
  '';


  # Oh My Zsh Plugins
  ohMyZsh = {
    plugins = [ "fzf" "history-substring-search" ];
  };


  shellAliases = {
    # Nix and NixOS aliases
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


    # General aliases
      # AIChat
        # Google Gemini
        aG = "aichat -m gemini";
        aGc = "aichat -m gemini --code";
        aGl = "aichat -m gemini --list-sessions";
        aGs = "aichat -m gemini --session";

      # Bat - A cat(1) clone with syntax highlighting and Git integration.
      # https://github.com/sharkdp/bat
      b = "bat --paging=always --style=plain --theme='Dracula' --wrap=auto" # Plain + paging=always
      bb =" bat --paging=never --style=plain --theme='Dracula' --wrap=auto" # Plain, no paging
      bnp = "bat --paging=always --style=numbers --theme='Dracula' --wrap=auto" # Numbers + paging=always

  };
}