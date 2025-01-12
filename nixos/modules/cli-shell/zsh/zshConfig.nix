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
    # Aliases moved to ./aliases.nix and ./aliases
  };


  # Shell initialization.
    # Shell script code called during interactive zsh shell initialisation.
    interactiveShellInit = ''
    '';

    # Shell script code called during zsh login shell initialisation.
    loginShellInit = ''
    '';

    # Shell script code called during zsh shell initialisation.
    shellInit = ''
      umask 0077

      # Needs https://github.com/nix-community/nix-index
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh

      # Preferred editor for local and remote sessions
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR="nvim"
        export VISUAL="code"
      else
        export EDITOR="nvim"
        export VISUAL="code"
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
}