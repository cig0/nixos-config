# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  # Ref: https://git-scm.com/docs/pretty-formats.

  aliases = {
    # Ungrouped git aliases
    gch = "git checkout";
    gcl = "git clone";
    gcl1 = "git clone --depth=1";
    gcp = "git cherry-pick";
    gls = "git ls-tree --full-tree --name-only -r HEAD | lines";
    gp = "git pull";
    gpu = "git push";
    grm = "git rm --cached";
    grs = "git restore --staged";

    # Add
    gaA = "git add --all";
    ga = "git add";
    gaf = "git add --force";

    # Branch
    gbD = "git branch --delete --force";
    gb = "git branch";
    gba = "git branch --all";

    # Commit
    gca = "git commit -am";
    gco = "git commit -m";

    # Fetch
    gf = "git fetch";
    gf1 = "git fetch --depth=1";

    # Log
    gloH = "git log origin..HEAD --oneline";
    glols = "git log --graph --pretty='\''%n%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%x2C'\'' --stat";
    glo = "git log --oneliner";

    # Status
    gsb = "git status --short --branch";
    gst = "git status";

    # Switch
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
