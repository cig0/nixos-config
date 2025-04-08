# TODO: migrate to Home Manager. It's a prio now (I'm lacking autocomplete for TAB). Also, VSCode expects to find the git config in the user home directory.
{
  config,
  lib,
  ...
}:
let
  cfg = config.mySystem.programs.git;
in
{
  options.mySystem.programs.git = {
    enable = lib.mkEnableOption "Whether to enable git, a distributed version control system.";
    lfs.enable = lib.mkEnableOption "Whether to enable git-lfs (Large File Storage).";
  };

  config = {
    # assertions = [
    # TODO: fix this assertion
    #   {
    #     assertion = !(config.programs.git.enable && config.home-manager.xdg.configFile."git/config".enable);
    #     message = "Only one of 'programs.git.enable' or 'myHM.xdg.configFile.\"git/config\".enable' can be enabled at a time.";
    #   }
    # ];

    programs.git = lib.mkIf cfg.enable {
      enable = true;
      config = {
        color = {
          diff = true;
          status = true;
          branch = true;
          interactive = true;
          ui = true;
          pager = true;
          log = true;
        };

        alias = {
          dft = "difftool";
          reset = "!sh -c 'echo -n \"Are you sure you want to reset? ALL CURRENT CHANGES WILL BE LOST! [YES/n/ctrl+c] \" && read ans && [ $ans = YES ] && git reset $@ || echo \"Reset aborted\"' -";
        };

        commit = {
          template = "~/.config/git/stCommitMsg";
          gpgsign = true;
        };

        core = {
          excludesFile = "/etc/gitignore";
          pager = "delta";
          hooksPath = "~/.config/git/hooks";
          editor = "nvim";
        };

        credential = {
          "https://github.com" = {
            helper = "!/run/current-system/sw/bin/gh auth git-credential";
          };
          "https://gist.github.com" = {
            helper = "!/run/current-system/sw/bin/gh auth git-credential";
          };
        };

        delta = {
          light = false;
          navigate = true;
          side-by-side = true;
          tabs = 2;
          true-color = "auto";
        };

        diff = {
          colorMoved = "default";
          tool = "difftastic";
        };

        difftool = {
          prompt = false;
        };

        "difftool \"difftastic\"" = {
          cmd = "difft \"$LOCAL\" \"$REMOTE\"";
        };

        filter.lfs = {
          process = "git-lfs filter-process";
          required = true;
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
        };

        gpg = {
          format = "ssh";
        };

        init.defaultBranch = "main";

        interactive = {
          diffFilter = "delta --color-only --tabs 2 --true-color auto";
        };

        "add.interactive" = {
          useBuiltin = false;
        };

        merge.conflictstyle = "diff3";

        pack = {
          packSizeLimit = "2g";
          threads = 2;
        };

        pager = {
          branch = false;
          difftool = true;
        };

        tag = {
          gpgsign = true;
          forceSignAnnotated = true;
        };

        url."git@github.com:" = {
          insteadOf = "https://github.com/";
        };

        user = {
          name = "Martín Cigorraga";
          email = "cig0.github@gmail.com";
          # signingkey = "BB81CA1B11628BF9929C7F733663FC5D6230F078"; # GPG key
          signingkey = "/home/cig0/.ssh/keys/GitHub/GitHub_Main";
        };

        # Color customizations for branch
        "color \"branch\"" = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };

        # Color customizations for diff
        "color \"diff\"" = {
          meta = "yellow bold";
          frag = "magenta bold";
          old = "red bold";
          new = "green bold";
        };

        # Color customizations for status
        "color \"status\"" = {
          added = "yellow";
          changed = "green";
          untracked = "cyan";
        };
      };
      lfs.enable = cfg.lfs.enable;
    };

    environment.etc."gitignore".text = ''
      *~
      myvars.tf
      testy-test
      *.kbdx
      .autoenv.zsh
      .autoenv_leave.zsh
      .cache_ggshield
      .DS_Store
      .env
      .favorites.json
      .vscode/
    '';
  };
}
