{ config, lib, ... }:

let
  cfg = config.mySystem.gnupg;

in {
  options.mySystem.gnupg = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable the GNU GPG agent";
  };

  config = lib.mkIf (cfg == "true") {
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