# Home Manager Zsh aliases module. Do not remove this header.
{
  nixosConfig,
  ...
}:
let
  # Ref: https://git-scm.com/docs/pretty-formats.

  aliases = {
    # Ungrouped git aliases
    gls = "git ls-tree --full-tree --name-only -r HEAD | lines";
    grm = "git rm --cached";

    # Add
    gaA = aliases.ga + " --all";
    ga = "git add";
    gaf = aliases.ga + " --force";

    # branch
    gbD = aliases.gb + " --delete --force";
    gb = "git branch";
    gba = aliases.gb + " --all";

    # cherry-pick
    gcpXt = aliases.gcp + " -X theirs";
    gcp = "git cherry-pick";
    gcpe = aliases.gcp + " -e";

    # clone
    gcl = "git clone";
    gcl1 = aliases.gcl + " --depth=1";

    # checkout
    gc = "git checkout";

    # commit
    gco = "git commit -m";
    gcoa = aliases.gco + " --amend";

    # diff
    gdi = "delta --paging=never";
    gdip = "delta --paging=auto";

    # fetch
    gf = "git fetch";
    gf1 = aliases.gf + " --depth=1";
    gfp = aliases.gf + " --prune";

    # log
    glols =
      aliases.glo
      + " --graph --pretty='\''%n%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%x2C'\'' --stat";
    glo = "git log";
    gloa1H = aliases.glo + " --all -1 --format=%H";
    gloa1 = aliases.glo + " --all -1 --format=%h";
    glooH = aliases.glo + " origin..HEAD --oneline";
    gloo = aliases.glo + " --oneline";

    # pull
    gp = "git pull";
    gpr = aliases.gp + " --rebase";

    # push
    gpu = "git push";
    gpusu = aliases.gpu + " --set-upstream origin $(git branch --show-current)";

    # reflog
    grefl1H = aliases.gref + " -1 --format=%H";
    gref = "git reflog";
    grefl1 = aliases.gref + " -1 --format=%h";

    # restore
    gr = "git restore";
    grs = aliases.gr + " --staged";

    # stash
    gst = "git stash";
    gstp = aliases.gst + " pop";

    # status
    gsb = aliases.gs + " --short --branch";
    gs = "git status";

    # switch
    gsw = "git switch";
    gswc = aliases.gsw + " --create";
    gswm = aliases.gsw + " main";
    gswd = aliases.gsw + " $GIT_REPO_NIXOS_CONFIG_CURRENT_DEV";
    gsws = aliases.gsw + " sandbox";

    # ===== Git helpers  =====
    gg = "/run/current-system/sw/bin/lazygit";
    ggF = "cd ${nixosConfig.mySystem.myOptions.nixos.flake.path} && " + aliases.gg + " && cd -";

    # GitGuardian
    ggs = "ggshield --no-check-for-updates";
    ggssr = aliases.ggs + " --no-check-for-updates secret scan repo";

    # GitHub CLI
    ghrw = "gh run watch";
    ghwv = "gh workflow view";
  };
in
{
  aliases = aliases;
}
