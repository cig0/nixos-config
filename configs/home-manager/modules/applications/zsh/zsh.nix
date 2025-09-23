{
  config,
  lib,
  libAnsiColors,
  nixosConfig,
  pkgs,
  self,
  ...
}:
let
  # Optionaly, you can import individual aliases and functions too
  allAliases = (import ./aliases.nix { inherit libAnsiColors nixosConfig; }).allAliases;
  allFunctions =
    (import ./functions.nix {
      inherit
        config
        libAnsiColors
        nixosConfig
        self
        ;
    }).allFunctions;

  /*
    Define the fzf-tab plugin source once. I know how TF get the route in the Nix store for the
    derivation, so this is the best way I found to get the path to source it in `initExtra`/
  */
  zshPlugin.fzfTabSrc = pkgs.fetchFromGitHub {
    owner = "Aloxaf";
    repo = "fzf-tab";
    rev = "v1.2.0";
    sha256 = "sha256-q26XVS/LcyZPRqDNwKKA9exgBByE0muyuNb0Bbar2lY=";
  };
in
{
  programs = {
    nix-index.enable = true;
    zsh = {
      enable = true;
      autocd = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      history = {
        append = true;
        expireDuplicatesFirst = true;
        extended = true;
        ignoreSpace = true;
        save = 20000;
        saveNoDups = true;
        share = true;
        size = 2000;
      };

      # Init
      initContent = ''
        umask 0077

        # Completion setup
        # Zsh completions configuration file: https://thevaluable.dev/zsh-completion-guide-examples/

        # Source fzf-tab (must be after compinit, before widget-wrapping plugins)
        source ${zshPlugin.fzfTabSrc}/fzf-tab.plugin.zsh

        # fzf-tab configuration
        # NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
        zstyle ':completion:*:git-checkout:*' sort false # disable sort when completing `git checkout` 
        zstyle ':completion:*:descriptions' format '[%d]' # set descriptions format to enable group support
        # zstyle ':completion:*' list-colors "''${(s.:.)" LS_COLORS} # set list-colors to enable filename colorizing
        zstyle ':completion:*' menu no # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
        # zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath' # preview directory's content with eza when completing cd
        # custom fzf flags
        # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
        zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
        # To make fzf-tab follow FZF_DEFAULT_OPTS.
        # NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
        zstyle ':fzf-tab:*' use-fzf-default-opts yes
        zstyle ':fzf-tab:*' switch-group '<' '>' # switch group using `<` and `>`

        setopt EXTENDED_HISTORY # Adds timestamps and durations to history entries
        setopt HIST_EXPIRE_DUPS_FIRST # Duplicate history entries are removed first when history file exceeds the limit
        setopt HIST_FCNTL_LOCK # Coordinate access to the history file across multiple Zsh processes
        setopt HIST_IGNORE_DUPS
        setopt RM_STAR_WAIT # Adds a 3-second delay before executing a dangerous rm * or rm path/* command

        # Controls how filename globbing behaves when there are no matches.
        # If no files match, the expansion expands to nothing instead of the name of the directory
        # or glob pattern, which most likely will break any script execution.
        # This is the equivalent to Bash's `shopt -s nullglob`.
        setopt NULL_GLOB

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

        # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
        COMPLETION_WAITING_DOTS="true"

        # Shell editing Emacs' style
        bindkey -e

        HIST_STAMPS="yyyy-mm-dd"

        # Initialize AWS environment
        . ~/.aws/env

        # Import functions
        unalias la > /dev/null 2>&1
        ${allFunctions}
      '';

      localVariables = { };

      oh-my-zsh = {
        enable = true;
        extraConfig = ''
          zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa2 id_github
        '';
        plugins = [
          "history-substring-search"
        ];
      };

      plugins = [
        {
          /*
            The Home Manager Zsh module loads plugins after compinit but before initExtra. This means
            that if you have any widget-wrapping plugins (like zsh-autosuggestions or fast-syntax-highlighting)
            defined in the plugins list, they would be loaded before fzf-tab if you source fzf-tab in initExtra.
            A better approach to `initExtraBeforeCompinit` in this case would be to ensure fzf-tab is
            the first plugin in your list, and then add any widget-wrapping plugins after it.
          */
          # Replace zsh's default completion selection menu with fzf!
          name = "fzf-tab";
          src = zshPlugin.fzfTabSrc;
        }
      ];

      sessionVariables = { };
      shellAliases = allAliases;
      syntaxHighlighting.enable = true;
    };
  };
}
/*
  Refs:
  https://superuser.com/questions/519596/share-history-in-multiple-zsh-shell
  https://unix.stackexchange.com/questions/669971/zsh-can-i-have-a-combined-history-for-all-of-my-shells
  https://github.com/cig0/Phantas0s-dotfiles/blob/master/zsh/zshrc
*/
