# Don't remove this line! This is a NixOS Zsh alias module.
{...}: let
  aliases = {
    # GitHub CLI
    ghrw = "gh run watch";
    ghwv = "gh workflow view";

    # Git
    # Adds an extra new line at the beginning of the pretty decoration.
    # https://git-scm.com/docs/pretty-formats.
    glols = "git log --graph --pretty='\''%n%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%x2C'\'' --stat";
    ga = "git add";
    gaA = "git add --all";
    gaf = "git add --force";
    gb = "git branch";
    gba = "git branch --all";
    gbD = "git branch --delete --force";
    gca = "git commit -am";
    gch = "git checkout";
    gcl = "git clone";
    gcl1 = "git clone --depth=1";
    gco = "git commit -m";
    gf = "git fetch";
    gf1 = "git fetch --depth=1";
    gls = "git ls-tree --full-tree --name-only -r HEAD | lines";
    gp = "git pull";
    gpu = "git push";
    grm = "git rm --cached";
    grss = "git restore --staged";

    # Git Log
    gloH = "git log origin..HEAD --oneline";

    # Git Status
    gsb = "git status --short --branch";
    gst = "git status";

    # Git Switch
    gsw = "git switch";
    gswc = "git switch --create";
    gswm = "git switch $\"\(git_main_branch\)\"";
    gswd = "git switch $\"\(git_develop_branch\)\"";
    gsws = "git switch sandbox";

    # Plus, related aliases/commands
    gg = "lazygit";

    # GitGuardian
    ggs = "ggshield --no-check-for-updates";
    ggssr = "ggshield --no-check-for-updates secret scan repo";
  };
in {aliases = aliases;}
