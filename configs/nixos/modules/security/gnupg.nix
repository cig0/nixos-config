{
  config,
  lib,
  ...
}: let
  cfg = config.mySystem.programs.gnupg;
in {
  options.mySystem.programs.gnupg.enable = lib.mkEnableOption "Whether to enable the GNU GPG agent";

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
