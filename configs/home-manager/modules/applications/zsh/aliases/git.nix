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
    gbrD = aliases.gbr + " --delete --force";
    gbr = "git branch";
    gbra = aliases.gbr + " --all";

    # cherry-pick
    gcpXt = aliases.gcp + " -X theirs";
    gcp = "git cherry-pick";
    gcpe = aliases.gcp + " -e";

    # clone
    gcl = "git clone";
    gcl1 = aliases.gcl + " --depth=1";

    # commit
    gcom = "git commit -m";
    gcoma = aliases.gcom + " --amend";

    # fetch
    gfe = "git fetch";
    gfe1 = aliases.gfe + " --depth=1";

    # log
    glols =
      aliases.glo
      + " --graph --pretty='\''%n%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%x2C'\'' --stat";
    glo = "git log";
    gloa1H = aliases.glo + " --all -1 --format=%H";
    gloa1 = aliases.glo + " --all -1 --format=%h";
    glooH = aliases.glo + " origin..HEAD --oneline";
    gloo = aliases.glo + " --oneline";

    # push
    gpu = "git push";
    gpum = aliases.gpu + " --mirror";
    gpusu = aliases.gpu + " --set-upstream origin $(git branch --show-current)";

    # reflog
    grefl1H = aliases.gref + " -1 --format=%H";
    gref = "git reflog";
    grefl1 = aliases.gref + " -1 --format=%h";

    # status
    gsb = aliases.gs + " --short --branch";
    gs = "git status";

    # switch
    gsw = "git switch";
    gswc = aliases.gsw + " --create";
    gswm = aliases.gsw + " main";
    gswd = aliases.gsw + " $\"\(git_develop_branch\)\""; # TODO: direnv? E.g. in the .env file: "git_development_branch=dev/refactor-module-loader-for-home-manager"
    gsws = aliases.gsw + " sandbox";

    # ===== Git helpers  =====
    gg = "lazygit";

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
