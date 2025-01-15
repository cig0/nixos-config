{ config, lib, ... }:

let
  cfg = config.mySystem.programs.gnupg;

in {
  options.mySystem.programs.gnupg = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable the GNU GPG agent";
  };

  config = lib.mkIf (cfg == true) {
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