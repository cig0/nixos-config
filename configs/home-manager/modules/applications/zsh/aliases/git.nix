# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  # Ref: https://git-scm.com/docs/pretty-formats.

  aliases = {
    # Ungrouped git aliases
    gch = "git checkout";
    gls = "git ls-tree --full-tree --name-only -r HEAD | lines";
    gp = "git pull";
    grm = "git rm --cached";
    grs = "git restore --staged";

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

    # commit
    gco = "git commit -m";
    gcoa = aliases.gco + " --amend";

    # fetch
    gf = "git fetch";
    gf1 = aliases.gf + " --depth=1";

    # log
    gloH = "git log origin..HEAD --oneline";
    glols = "git log --graph --pretty='\''%n%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%x2C'\'' --stat";
    glo = "git log --oneline";

    # push
    gpu = "git push";
    gpum = aliases.gpu + " --mirror";

    # reflog
    grlH1 = aliases.grl + " --format=%H -1"; # Shows latest commit in long-format
    grl = "git reflog";
    grlh1 = aliases.grl + " --format=%h -1"; # Shows latest commit in short-format

    # status
    gsb = "git status --short --branch";
    gs = "git status";

    # switch
    gsw = "git switch";
    gswc = "git switch --create";
    gswm = "git switch $\"\(git_main_branch\)\"";
    gswd = "git switch $\"\(git_develop_branch\)\"";
    gsws = "git switch sandbox";

    # ===== Git helpers  =====
    gg = "lazygit";

    # GitGuardian
    ggs = "ggshield --no-check-for-updates";
    ggssr = "ggshield --no-check-for-updates secret scan repo";

    # GitHub CLI
    ghrw = "gh run watch";
    ghwv = "gh workflow view";
  };
in
{
  aliases = aliases;
}
