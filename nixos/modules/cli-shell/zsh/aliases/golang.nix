# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  aliases = {
    cdgosrc = "cd $(go env GOPATH)/src";
    go_clean_vcs_cache = "rm -rf $GOPATH/pkg/mod/cache/vcs";
  };

in { aliases = aliases; }