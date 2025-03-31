/*
  TODO_ add options

  fzf is currently installed via the NixOS module packages.nix.

  I am still evaluating whether to manage as many applications as possible using Home Manager, given the extensive configuration options it provides, or to handle them as independent packages and configure the tools manually.

  In general, I tend to favor using NixOS' native options for configuration, even though they may offer less flexibility for personalization compared to the options provided by Home Manager.
*/
{ ... }:
{
  programs.fzf = {
    enable = false;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };
}
