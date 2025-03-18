{
  pkgs,
  ...
}:
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

  xdg.configFile."apps-cargo".text = ''
    # Hola desde NixOS!
    # List of applications and tools managed with Rust's package manager Cargo

    # blue-build
      # BlueBuild's command line program that builds Containerfiles and custom images based on your recipe.yml
      # https://github.com/blue-build/cli

    jumpy
      # Jumpy is a tool that allows to quickly jump to one of the directory you've visited in the past.
      # https://github.com/ClementNerma/Jumpy

    # podlet :: it has been added to NixOS repository 8D
      # Podlet generates podman quadlet files from a podman command, compose file, or existing object.
      # https://github.com/containers/podlet

    trasher
      # A small command-line utility to replace 'rm' and 'del' by a trash system
      # https://github.com/ClementNerma/Trasher
  '';
}
