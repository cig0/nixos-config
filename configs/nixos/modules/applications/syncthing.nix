# TODO: Evaluate migrating to Home Manager once NixOS 25.05 is released
{
  config,
  lib,
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
          user = "cig0";
          password = config.mySecrets.getSecret "shared.services.syncthing.settings.gui.password";
          options = {
            minHomeDiskFree = {
              unit = "GB";
              value = 50;
            };
            maxFolderConcurrency = 2;
            urAccepted = 2; # Send telemetry
          };
          devices = {
            #   perrrkele = {
            #     id = "";
            #   };
            #   homelabnas = {
            #     id = "";
            #   };
            desktop = {
              id = config.mySecrets.getSecret "shared.services.syncthing.settings.gui.devices.desktop";
            };
            # folders = {
            #   ".aws" = {
            #     # id = "m3q6z-itat6";
            #     label = ".aws";
            #     path = "/home/cig0/.aws";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   ".krew" = {
            #     # id = "zo6vm-ycvnv";
            #     label = ".krew";
            #     path = "/home/cig0/.krew";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   ".kube" = {
            #     # id = "cbvut-r9kxc";
            #     label = ".kube";
            #     path = "/home/cig0/.kube";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   ".ssh" = {
            #     # id = "7cgim-4pyuc";
            #     label = ".ssh";
            #     path = "/home/cig0/.ssh";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   ".terraform.versions" = {
            #     # id = "uoocx-gswyo";
            #     label = ".terraform.versions";
            #     path = "/home/cig0/.terraform.versions";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   "Default Folder" = {
            #     id = "default";
            #     label = "Default Folder";
            #     path = "/home/cig0/Sync";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   "Desktop" = {
            #     # id = "bevao-ecdck";
            #     label = "Desktop";
            #     path = "/home/cig0/Desktop";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   "Documents" = {
            #     # id = "4plzj-q9hjx";
            #     label = "Documents";
            #     path = "/home/cig0/Documents";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   "Downloads" = {
            #     # id = "v72dy-fzjsf";
            #     label = "Downloads";
            #     path = "/home/cig0/Downloads";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   "KeePassXC" = {
            #     # id = "nsqaf-gequ7";
            #     label = "KeePassXC";
            #     path = "/home/cig0/KeePassXC";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   "Pictures" = {
            #     # id = "zhepz-tkl9u";
            #     label = "Pictures";
            #     path = "/home/cig0/Pictures";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   "stash" = {
            #     # id = "inznp-cjdxe";
            #     label = "stash";
            #     path = "/home/cig0/stash";
            #     devices = [
            #       "perrrkele"
            #       "desktop"
            #     ];
            #   };
            #   "Videos" = {
            #     # id = "g7amc-cstmt";
            #     label = "Videos";
            #     path = "/home/cig0/Videos";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   "bin" = {
            #     # id = "mtzdy-xgvcf";
            #     label = "bin";
            #     path = "/home/cig0/bin";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #   };
            #   "w" = {
            #     # id = "rn6um-4btcp";
            #     label = "w";
            #     path = "/home/cig0/w";
            #     devices = [
            #       "perrrkele"
            #       "homelabnas"
            #       "desktop"
            #     ];
            #     versioning.type = "simple";
            #   };
          };
        };
      };
    };
  };
}
