# TODO:
# - Split interactiveShellInit
# - Split shellAliases
# - Evaluate configuring Zsh with Home Manager

{ pkgs }:

let
    # === ANSI escape codes for colors ===
    # Note the double forward slash for the escape sequences !
    # Otherwise Nix will render the content of the string like
    # regular characters.
    bold_green = "\\e[1;32m";
    bold_white = "\\e[1;97m";
    italic = "\\033[3m";
    reset = "\\e[0m"; # ANSI escape code for resetting text attributes

in rec {
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
    # ANSI escape codes for colors
    local bold_green="\e[1;32m"
    local bold_white="\e[1;97m"
    # ANSI escape code for resetting text attributes
    local reset="\e[0m"

    # Other functions
      # TODO: understand why this command isn't being evaluated
      # Atuin - bind ctrl-r but not up arrow
      # [ -x "$(command -v atuin)" ] && source "$HOME/.config/atuin/init.zsh"

    alse() {
      [[ -z $1 ]] && \
        echo -e "\n${bold_white}Missing alias to search!${reset}\n\nSyntax: ${bold_green}alse ${italic}alias_to_search${reset}" && \
          return 1
      alias | grep --color=always --ignore-case "$1"
    }

    # Diff
    diffstring() {
      # Using delta :: https://github.com/dandavison/delta
      d <(echo "$1") <(echo "$2")
    }

    # General
    bkp() {
      source=$1
      cp -i "$source" "$source.bkp"
    }
    freemem() {
      printf '\n=== Superuser password required to elevate permissions ===\n\n'
      su -c "echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\\n%s\\n' 'RAM-cache and Swap Cleared'" root
    }

    # Kubernetes
    kla() {
      # List all resources
      kubectl api-resources --verbs=list --namespaced -o name | xargs -t -n 1 kubectl get --show-kind --ignore-not-found "$@"
    }
    kla_events() {
      # List all events
      for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
        echo "Resource:" $i

        if [ -z "$1" ]
        then
            kubectl get --ignore-not-found $i
        else
            kubectl -n $1 get --ignore-not-found $i
        fi
      done
    }
    kdecrypts() {
      # Secret decrypt
      # $1 = secret name
      # $2 = .data.{OBJECT}
      kubectl get secret "$1" -o jsonpath="{.data.$2}" | base64 --decode
    }

    # Podman
    prminone() {
      podman rmi --force $(podman images | grep -i '<none>' | awk -F' ' '{ print $3 }')
    }

    # Visual Studio Code
    c() {
      /run/current-system/sw/bin/code --profile cig0 --enable-features=VaapiVideoDecodeLinuxGL --ignore-gpu-blocklist --enable-zero-copy --enable-features=UseOzonePlatform --ozone-platform=wayland $@
    }
  '';


  loginShellInit = interactiveShellInit;


  shellInit = ''
    umask 0077
    fpath+=~/.zfunc

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


  # Oh My Zsh Plugins
  ohMyZsh = {
    plugins = [ "fzf" "history-substring-search" ];
  };


  shellAliases = {
    # Aliases moved to ./aliases
  };
}
