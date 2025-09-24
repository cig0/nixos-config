# @MODULON_SKIP
# TODO: revisit with NixOS 25.05
{ ... }:
{
  programs.fzf = {
    fuzzyCompletion = true;
  };
}
