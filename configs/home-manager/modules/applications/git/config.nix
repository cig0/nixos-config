{
  config,
  lib,
  nixosConfig,
  ...
}:
let
  cfg = nixosConfig.myHm.programs.git;

in
{
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = cfg.lfs.enable;
      extraConfig = {
        color = {
          diff = true;
          status = true;
          branch = true;
          interactive = true;
          ui = true;
          pager = true;
          log = true;
        };

        commit = {
          template = "${config.home.homeDirectory}/.config/git/stCommitMsg";
          gpgsign = true;
        };

        core = {
          excludesFile = "${config.home.homeDirectory}/.config/git/gitignore";
          pager = "delta";
          # hooksPath = "${config.home.homeDirectory}/.config/git/hooks";
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

        # include.path = "${config.home.homeDirectory}/.config/git/git-aliases.conf";
        # For aliases
        "include" = {
          path = "${config.home.homeDirectory}/.config/git/gitconfig-aliases";
        };

        # For work repositories
        "includeIf \"gitdir:${config.home.homeDirectory}/workdir/work/\"" = {
          path = "${config.home.homeDirectory}/.config/git/gitconfig-work";
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

        # Use with caution: It may break some repositories if they are set to stick to an specific branch
        # remote = {
        #   origin = {
        #     # If `git ls-remote --heads origin` shows the remote branches correctly, but
        #     # `git branch -r` does not, try: `git config --get remote.origin.fetch`
        #     fetch = "+refs/heads/*:refs/remotes/origin/*";
        #   };
        # };

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
          signingkey = "${config.home.homeDirectory}/.ssh/keys/github_main";
          # signingkey = "${inputs.self}/${nixosConfig.mySecrets.getSecret "shared.home-manager.git.github.personal.ssh_pk"}";
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
    };
  };
}
