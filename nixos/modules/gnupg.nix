# GNU GPG
{ ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = {
      defaultCacheTTL = 86400;
      maxCacheTTL = 86400;
    };
  };
}