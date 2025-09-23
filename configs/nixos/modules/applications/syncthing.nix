# TODO:  evaluate moving to Home Manager when 25.05 arrives
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myNixos = {
    myOptions = {
      services.syncthing.guiAddress.port = lib.mkOption {
        type = lib.types.port;
      };
    };
  };

  config = lib.mkIf config.services.syncthing.enable {
    services.syncthing = {
      guiAddress = "${config.myNixos.myOptions.services.tailscale.ip}:${toString config.myNixos.myOptions.services.syncthing.guiAddress.port}";
      openDefaultPorts = true;
      user = "cig0";
      group = "users";
      dataDir = "/home/cig0";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        gui = {
          user = config.mySecrets.getSecret "shared.services.syncthing.settings.gui.user";
          password = config.mySecrets.getSecret "shared.services.syncthing.settings.gui.password";
          options = {
            maxFolderConcurrency = 2;
            urAccepted = 2; # Send telemetry
          };
        };
        devices = {
          #   homelabnas = {
          #     id = "";
          #   };
          desktop = {
            id = config.mySecrets.getSecret "shared.services.syncthing.settings.gui.devices.desktop";
          };
          tuxedo = {
            id = config.mySecrets.getSecret "shared.services.syncthing.settings.gui.devices.tuxedo";
          };
        };
        folders = {
          #   ".aws" = {
          #     id = "aws";
          #     label = ".aws";
          #     path = "/home/cig0/.aws";
          #     devices = [
          #       "tuxedo"
          #       "homelabnas"
          #       "desktop"
          #     ];
          #   };
          #   ".krew" = {
          #     # id = "zo6vm-ycvnv";
          #     label = ".krew";
          #     path = "/home/cig0/.krew";
          #     devices = [
          #       "tuxedo"
          #       "homelabnas"
          #       "desktop"
          #     ];
          #   };
          #   ".kube" = {
          #     # id = "cbvut-r9kxc";
          #     label = ".kube";
          #     path = "/home/cig0/.kube";
          #     devices = [
          #       "tuxedo"
          #       "homelabnas"
          #       "desktop"
          #     ];
          #   };
          ".ssh" = {
            # id = "7cgim-4pyuc";
            label = ".ssh";
            path = "/home/cig0/.ssh";
            devices = [
              "desktop"
              # "homelabnas"
              "tuxedo"
            ];
          };
          #   ".terraform.versions" = {
          #     # id = "uoocx-gswyo";
          #     label = ".terraform.versions";
          #     path = "/home/cig0/.terraform.versions";
          #     devices = [
          #       "desktop"
          #       "homelabnas"
          #       "tuxedo"
          #     ];
          #   };
          "Default Folder" = {
            id = "default";
            label = "Default Folder";
            path = "/home/cig0/Sync";
            devices = [
              "desktop"
              # "homelabnas"
              "tuxedo"
            ];
          };
          "Desktop" = {
            id = "desktop";
            label = "Desktop";
            path = "/home/cig0/Desktop";
            devices = [
              "desktop"
              # "homelabnas"
              "tuxedo"
            ];
          };
          "Documents" = {
            id = "documents";
            label = "Documents";
            path = "/home/cig0/Documents";
            devices = [
              "desktop"
              # "homelabnas"
              "tuxedo"
            ];
          };
          # "Downloads" = {
          #   id = "downloads";
          #   label = "Downloads";
          #   path = "/home/cig0/Downloads";
          #   devices = [
          #     "desktop"
          #     # "homelabnas"
          #     "tuxedo"
          #   ];
          # };
          "eBooks" = {
            id = "ebooks";
            label = "eBooks";
            path = "/home/cig0/eBooks";
            devices = [
              "desktop"
              # "homelabnas"
              "tuxedo"
            ];
          };
          "KeePassXC" = {
            id = "keepassxc";
            label = "KeePassXC";
            path = "/home/cig0/KeePassXC";
            devices = [
              "tuxedo"
              # "homelabnas"
              "desktop"
            ];
          };
          "Pictures" = {
            id = "pictures";
            label = "Pictures";
            path = "/home/cig0/Pictures";
            devices = [
              "tuxedo"
              # "homelabnas"
              "desktop"
            ];
          };
          #   "stash" = {
          #     # id = "inznp-cjdxe";
          #     label = "stash";
          #     path = "/home/cig0/stash";
          #     devices = [
          #       "desktop"
          #       "tuxedo"
          #     ];
          #   };
          #   "Videos" = {
          #     # id = "g7amc-cstmt";
          #     label = "Videos";
          #     path = "/home/cig0/Videos";
          #     devices = [
          #       "desktop"
          #       # "homelabnas"
          #       "tuxedo"
          #     ];
          #   };
          "bin" = {
            id = "bin";
            label = "bin";
            path = "/home/cig0/bin";
            devices = [
              "desktop"
              # "homelabnas"
              "tuxedo"
            ];
          };
          "exe" = {
            id = "exe";
            label = "exe";
            path = "/home/cig0/exe";
            devices = [
              "desktop"
              # "homelabnas"
              "tuxedo"
            ];
          };
          # "workdir" = {
          #   id = "workdir";
          #   label = "workdir";
          #   path = "/home/cig0/workdir";
          #   devices = [
          #     "desktop"
          #     # "homelabnas"
          #     "tuxedo"
          #   ];
          # versioning.type = "simple";
          # };
        };
      };
    };

    systemd.services.syncthing = {
      after = [
        "tailscaled.service"
        "network-online.target"
      ];
      wants = [
        "tailscaled.service"
        "network-online.target"
      ];
      bindsTo = [ "tailscaled.service" ];
      unitConfig.ConditionExecStartPre = [
        "${pkgs.bash}/bin/bash -c ip a show tailscale0 | ${pkgs.gnugrep} -q \"inet ${config.myNixos.myOptions.services.tailscale.ip}\""
      ]; # Avoid failure on boot if Tailscale isn't up
      serviceConfig = {
        RestartSec = 5;
      };
    };
  };
}
