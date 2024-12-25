# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aliases = {
    cdgosrc = "cd $(go env GOPATH)/src";
    go_clean_vcs_cache = "rm -rf $GOPATH/pkg/mod/cache/vcs";
  };

in {
  aliases = aliases;
}