# TODO: Add systemd service to install plugins if not present

{
  config,
  lib,
  ...
}:
{
  options.mySystem.programs.krew = {
    enable = lib.mkEnableOption "Whether to enable and manage Krew, a package manager for kubectl plugins.";
    install = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "A list of plugins to install.";
      example = [
        "ktop"
        "slowdrain"
      ];
    };
  };

  config = lib.mkIf config.mySystem.programs.krew.enable {
    mySystem.programs.krew.install = config.mySystem.programs.krew.install;

    # systemd.services.krew-install-plugins = {
    #   description = "Install Krew plugins";
    #   wantedBy = [ "multi-user.target" ];
    #   after = [ "network-online.target" ];
    #   wants = [ "network-online.target" ];
    #   serviceConfig = {
    #     Type = "oneshot";
    #     RemainAfterExit = false;
    #     User = "cig0"; # Or specify a specific user that needs the plugins
    #   };
    #   script = ''
    #     krew install ${lib.concatStringsSep " " config.mySystem.programs.krew.install}
    #   '';
    # };
  };
}
