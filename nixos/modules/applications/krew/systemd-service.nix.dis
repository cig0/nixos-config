# TODO: should I move this to Home Manager so we can configure this systemd service that installs Krew plugins on a per-user basis?
# This way I can fulyl replicate the Krew setup accross the different users on a same host, e.g. for the backup user.

{
  config,
  lib,

{
  systemd.services.krew-install-plugins = {
    description = "Install Krew plugins";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = false;
      User = "cig0"; # Or specify a specific user that needs the plugins
    };
    script = ''
      krew install ${lib.concatStringsSep " " config.mySystem.programs.krew.install}
    '';
  };
}
