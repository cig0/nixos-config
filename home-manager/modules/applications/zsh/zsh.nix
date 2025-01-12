{ config, pkgs, ... }:

let
  # Optionaly, you can import individual aliases and functions.
    allAliases = (import ./aliases.nix {}).allAliases;
    allFunctions = (import ./functions.nix { inherit config; }).allFunctions;

in {
  programs.command-not-found.enable = false;

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    completionInit = "autoload -Uz compinit && compinit -C";
    shellAliases = allAliases;
    history = {
      append = true;
      expireDuplicatesFirst = true;
      extended = true;
      ignoreSpace = true;
      save = 20000;
      share = true;
    };

    # Init
    initExtraFirst = ''
      umask 0077
    '';
    initExtra = ''
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

      eval "$(atuin init --disable-up-arrow zsh)"
      eval "$(starship init zsh)"
      . "$XDG_HOME/.aws/env"

      # Import functions
      unalias la
      ${allFunctions}
    '';

    oh-my-zsh = {
      enable = true;
      extraConfig = ''
          zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa2 id_github
      '';
      plugins = [
        "history-substring-search"
      ];
    };
  };
}