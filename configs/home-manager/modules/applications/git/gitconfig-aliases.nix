{
  nixosConfig,
  self,
  ...
}:
let
  constants = import "${self}/configs/home-manager/modules/common/values/constants.nix" nixosConfig;
  gitDirWorkTreeFlake = constants.gitDirWorkTreeFlake;
in
{
  xdg.configFile."git/gitconfig-aliases".text = ''
    # Ref: https://git-scm.com/docs/pretty-formats.
    [alias]
    # Ungrouped git aliases
    gls = "ls-tree --full-tree --name-only -r HEAD | lines";
    grm = "rm --cached";
    reset = "!sh -c 'echo -n \"Are you sure you want to reset? ALL CURRENT CHANGES WILL BE LOST! [YES/n/ctrl+c] \" && read ans && [ $ans = YES ] && git reset $@ || echo \"Reset aborted\"' -";

    # Add
    aA = "add --all";
    a = "add";
    af = "add --force";
    aFs = "${gitDirWorkTreeFlake} add secrets";

    # branch
    bD = "branch --delete --force";
    b = "branch";
    ba = "branch --all";

    # cherry-pick
    cpXt = "cherry-pick -X theirs";
    cp = "cherry-pick";
    cpe = "cherry-pick -e";

    # clone
    cl = "clone";
    cl1 = "clone --depth=1";

    # checkout
    c = "checkout";

    # commit
    co = "commit -m";
    coa = "commit --amend";

    # diff
    dft = "!difftool";
    di = "!delta --paging=never";
    dip = "!delta --paging=auto";

    # fetch
    f = "fetch";
    f1 = "fetch --depth=1";
    fp = "fetch --prune";

    # log
    glols = "log --graph --pretty='%n%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%x2C' --stat";
    lo = "log";
    loa1H = "log --all -1 --format=%H";
    loa1 = "log --all -1 --format=%h";
    looH = "log origin..HEAD --oneline";
    loo = "log --oneline";

    # pull
    p = "pull";
    pr = "pull --rebase";

    # New alias: Pull, showing incoming commits with files changed (using --name-status) before merging
    pns = "!f() { \
        local remote=''${1:-origin}; \
        echo \"Fetching updates from $remote...\"; \
        git fetch $remote && \
        echo; echo 'Incoming commits (with files changed):'; \
        git log --name-status --oneline \"..@{u}\"; \
        echo; echo 'Merging updates...\"; \
        git merge --no-edit \"@{u}\"; \
    }; f"

    # New alias: Pull, showing incoming commits with files changed (using --stat) before merging
    ps = "!f() { \
        local remote=''${1:-origin}; \
        echo \"Fetching updates from $remote...\"; \
        git fetch $remote && \
        echo; echo 'Incoming commits (with files changed):'; \
        git log --stat --oneline \"..@{u}\"; \
        echo; echo 'Merging updates...\"; \
        git merge --no-edit \"@{u}\"; \
    }; f"

    # Optional: Rebase version of ps
    psr = "!f() { \
        local remote=''${1:-origin}; \
        echo \"Fetching updates from $remote...\"; \
        git fetch $remote && \
        echo; echo 'Incoming commits (with files changed):'; \
        git log --stat --oneline \"..@{u}\"; \
        echo; echo 'Rebasing updates...\"; \
        git rebase \"@{u}\"; \
    }; f"

    # push
    P = "push";
    pusu = "!git push --set-upstream origin $(git branch --show-current)";

    # reflog
    refl1H = "reflog -1 --format=%H";
    ref = "reflog";
    refl1 = "reflog -1 --format=%h";

    # restore
    r = "restore";
    rs = "restore --staged";
    rsF = "${gitDirWorkTreeFlake} restore --staged && gsbF";
    rsFs = "${gitDirWorkTreeFlake} restore --staged secrets && gsbF";

    # stash
    st = "stash";
    stp = "stash pop";

    # status
    s = "status";
    sb = "status --short --branch";
    sbF = "${gitDirWorkTreeFlake} status --short --branch";

    # switch
    sw = "switch";
    swc = "switch --create";
    swd = "switch develop";
    swm = "switch main";
    sws = "switch sandbox";
  '';
}
