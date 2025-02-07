# TODO: I need options only available in 25.05 (unstable). When the moment comes to configure Syncthing through Home Manager, I will need to switch the flake input to 'nixpkgs-unstable'.
{
  config,
  lib,
  ...
}: let
  cfg = config.mySystem.services.syncthing;
in {
  options.mySystem.services.syncthing = lib.mkOption {
    type = lib.types;
    default = false;
    description = "Whether to enable Syncthing service";
  };

  config = lib.mkIf (cfg == true) {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = "cig0";
      group = "users";
      dataDir = "/home/cig0";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        gui = {
          user = "cig0";
          password = ""; # TODO: manage with SOPS-Nix
        };
        options = {
          minHomeDiskFree = {
            unit = "GB";
            value = 50;
          };
          maxFolderConcurrency = 2;
          urAccepted = 2; # Send telemetry
        };
        devices = {
          perrrkele = {
            id = "I7UYHKV-NU5RSCD-LSZHJ47-LFZY2JE-QKWUTB5-LAZRA7S-S6ZZS3S-2QNVLAA";
          };
          homelabnas = {
            id = "DZTYQXD-3RE6PHR-QM7EE3X-DVXNEQQ-7ONTWG4-NYK4CUZ-RFVZTAV-L6MSPQJ";
          };
          desktop = {
            id = "B6KWO2N-6PMBFS2-6RR7FPB-DUZDDVA-6T5YSUV-K64WG2W-VR32G4C-I3H74QW";
          };
        };
        folders = {
          ".aws" = {
            id = "m3q6z-itat6";
            label = ".aws";
            path = "/home/cig0/.aws";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          ".krew" = {
            id = "zo6vm-ycvnv";
            label = ".krew";
            path = "/home/cig0/.krew";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          ".kube" = {
            id = "cbvut-r9kxc";
            label = ".kube";
            path = "/home/cig0/.kube";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          ".ssh" = {
            id = "7cgim-4pyuc";
            label = ".ssh";
            path = "/home/cig0/.ssh";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          ".terraform.versions" = {
            id = "uoocx-gswyo";
            label = ".terraform.versions";
            path = "/home/cig0/.terraform.versions";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          "Default Folder" = {
            id = "default";
            label = "Default Folder";
            path = "/home/cig0/Sync";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          "Desktop" = {
            id = "bevao-ecdck";
            label = "Desktop";
            path = "/home/cig0/Desktop";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          "Documents" = {
            id = "4plzj-q9hjx";
            label = "Documents";
            path = "/home/cig0/Documents";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          "Downloads" = {
            id = "v72dy-fzjsf";
            label = "Downloads";
            path = "/home/cig0/Downloads";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          "KeePassXC" = {
            id = "nsqaf-gequ7";
            label = "KeePassXC";
            path = "/home/cig0/KeePassXC";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          "Pictures" = {
            id = "zhepz-tkl9u";
            label = "Pictures";
            path = "/home/cig0/Pictures";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          "stash" = {
            id = "inznp-cjdxe";
            label = "stash";
            path = "/home/cig0/stash";
            devices = ["perrrkele" "desktop"];
          };
          "Videos" = {
            id = "g7amc-cstmt";
            label = "Videos";
            path = "/home/cig0/Videos";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          "bin" = {
            id = "mtzdy-xgvcf";
            label = "bin";
            path = "/home/cig0/bin";
            devices = ["perrrkele" "homelabnas" "desktop"];
          };
          "w" = {
            id = "rn6um-4btcp";
            label = "w";
            path = "/home/cig0/w";
            devices = ["perrrkele" "homelabnas" "desktop"];
            versioning.type = "simple";
          };
        };
      };
    };
  };
}
