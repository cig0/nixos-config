{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixos.programs.gnupg;
in
{
  options.myNixos.programs.gnupg = {
    enable = lib.mkEnableOption "Whether to enable the GNU GPG agent";
    enableSSHSupport = lib.mkEnableOption "Whether to enable SSH support for the GNU GPG agent";
  };

  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = config.myNixos.programs.gnupg.enableSSHSupport;
      settings = {
        default-cache-ttl = 86400;
        max-cache-ttl = 86400;
      };
    };
  };
}
