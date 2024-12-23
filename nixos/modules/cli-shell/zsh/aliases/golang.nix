# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Golang
  golang = {
    cdgosrc = "cd $(go env GOPATH)/src";
    go_clean_vcs_cache = "rm -rf $GOPATH/pkg/mod/cache/vcs";
  };

in {
  golang = golang;
}