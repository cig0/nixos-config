{
  config,
  lib,
  ...
}: let
  cfg = config.myNixos.programs.gnupg;
in {
  options.myNixos.programs.gnupg.enable = lib.mkEnableOption "Whether to enable the GNU GPG agent";

  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      settings = {
        default-cache-ttl = 86400;
        max-cache-ttl = 86400;
      };
    };
  };
}
