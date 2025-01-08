# home-manager/modules/user/maintenance/apps-cargo.nix
{ pkgs, ... }:

{
  systemd.user = {
    services = {
      cargo-upgrade = {
        Unit = {
          Description = "Upgrade Cargo packages";
          After = [ "network-online.target" ];
          Wants = [ "network-online.target" ];
        };

        Service = {
          Type = "oneshot";
          Environment = "XDG_CONFIG_HOME=%h/.config";
          ExecStart = "${pkgs.zsh}/bin/zsh -c 'source /etc/zshrc && _upgrade-apps-cargo'";
          Restart = "no";
          ProtectSystem = "strict";
          ProtectHome = "no";
          NoNewPrivileges = true;
        };

        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };

    timers = {
      cargo-upgrade = {
        Unit = {
          Description = "Timer for Cargo packages upgrade";
        };

        Timer = {
          OnCalendar = "weekly";
          Persistent = true;
          RandomizedDelaySec = "45min";
          OnBootSec = "15min";
          OnUnitActiveSec = "1w";
        };

        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}