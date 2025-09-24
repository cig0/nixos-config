# Home Manager Zsh aliases module. Do not remove this header.
{
  ...
}:
let
  aliases = {
    cdgosrc = "cd $(go env GOPATH)/src";
    go_clean_vcs_cache = "rm -rf $GOPATH/pkg/mod/cache/vcs";
  };
in
{
  inherit aliases;
}
