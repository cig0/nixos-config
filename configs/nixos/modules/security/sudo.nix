# Hardening tips: https://xeiaso.net/blog/paranoid-nixos-2021-07-18/
{
  config,
  lib,
  ...
}:
let
  cfg = {
    enable = config.myNixos.security.sudo.enable;
    extraConfig = config.myNixos.ecurity.sudo.extraConfig;
  };
  defaultExtraConfig = ''
    Defaults env_reset, env_keep="SSH_AUTH_SOCK"
  '';
in
{
  options.myNixos.security.sudo = {
    enable = lib.mkEnableOption "Whether to enable the {command}`sudo` command, which
allows non-root users to execute commands as root.";

    extraConfig = lib.mkOption {
      type = lib.types.nullOr lib.types.lines;
      default = defaultExtraConfig;
      description = "Extra configuration text appended to {file}`sudoers`.";
    };
  };

  config = lib.mkIf cfg.enable {
    security.sudo = {
      enable = true;
      execWheelOnly = true;
      extraConfig = lib.mkMerge [
        defaultExtraConfig
        config.myNixos.security.sudo.extraConfig
      ];
    };
  };
}
