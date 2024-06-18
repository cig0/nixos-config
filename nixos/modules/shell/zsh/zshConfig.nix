{ pkgs }:

let
  nixos = import ./nixos.nix;
in
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

    ${nixos}
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