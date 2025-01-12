{ pkgs }:

{
  # Oh My Zsh Plugins
  ohMyZsh = {
    plugins = [ "fzf" "history-substring-search" ];
  };


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
    "COMPLETE_ALIASES"

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


  shellAliases = {
    # Aliases moved to ./aliases.nix and ./aliases.
  };


  # Shell initialization.
    # Shell script code called during interactive zsh shell initialisation.
    interactiveShellInit = ''
      # Completion setup
        # Zsh completions configuration file: https://thevaluable.dev/zsh-completion-guide-examples/

        autoload -Uz compinit
        compinit -C

        unsetopt no_complete_aliases
        zstyle ':completion:*' completer _expand_alias _extensions _complete _approximate
        # zstyle ':completion:*' completer _expand _complete _ignored _correct _path_files _approximate _prefix _camel_case
        zstyle ':completion:*' expand prefix suffix
        zstyle ':completion:*' squeeze-slashes true
        zstyle ':completion:*' matcher-list 'r:[^A-Z0-9]||[A-Z0-9]=** r:|=*'
        zstyle ':completion:*' list-dirs-first true
        zstyle ':completion:*' menu select

        # Caching completions
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$HOME/.cache/zcompcache"
        zstyle ':completion:*' group-name null

      # Needs https://github.com/nix-community/nix-index
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh

      # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
      COMPLETION_WAITING_DOTS="true"

      # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
      # or set a custom format using the strftime function format specifications,
      # see 'man strftime' for details.
      # HIST_STAMPS="mm/dd/yyyy"
      HIST_STAMPS="yyyy-mm-dd"

      # Shell editing Emacs' style
      bindkey -e
    '';

    # Shell script code called during zsh login shell initialisation.
    loginShellInit = ''
    '';

    # Shell script code called during zsh shell initialisation.
    shellInit = ''
      umask 0077

      # Preferred editor for local and remote sessions
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR="nvim"
        export VISUAL="code"
      else
        export EDITOR="nvim"
        export VISUAL="code"
      fi
    '';
}