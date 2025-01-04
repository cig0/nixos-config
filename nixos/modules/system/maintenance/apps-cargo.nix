# Systemd timer that runs a service to upgrade Cargo packages defined in $HOME/.config/apps.cargo weekly.

{ pkgs, ... }:

{
  systemd.services.cargo-upgrade = {
    description = "Upgrade Cargo packages";

    # Ensure network is available
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    # Environment setup
    environment = {
      HOME = "%h";
      XDG_CONFIG_HOME = "%h/.config";
    };

    serviceConfig = {
      Type = "oneshot";
      User = "cig0";
      # Ensure cargo binary is available
      Path = [
        "${pkgs.cargo}/bin"
        "${pkgs.cargo-binstall}/bin"
      ];
      ExecStart = "${pkgs.zsh}/bin/zsh -c 'source /etc/zshrc && _upgrade.apps.cargo'";

      # Safety measures
      RuntimeMaxSec = "10m";
      Restart = "no";
      ProtectSystem = "strict";
      ProtectHome = "no";
      NoNewPrivileges = true;
    };
  };

  systemd.timers.cargo-upgrade = {
    description = "Timer for Cargo packages upgrade";
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
      RandomizedDelaySec = "45min";
      # Avoid running when on battery
      OnBootSec = "15min";
      OnUnitActiveSec = "1w";
      Unit = "cargo-upgrade.service";
    };
  };
}