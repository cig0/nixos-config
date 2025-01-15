# TODO: I need options only available in 25.05 (unstable). When the moment comes to configure Syncthing through Home Manager, I will need to switch the flake input to 'nixpkgs-unstable'.

{ config, lib, ... }:

let
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
          password = "siga";
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
          TUXEDOInfinityBookPro ={
            id = "I7UYHKV-NU5RSCD-LSZHJ47-LFZY2JE-QKWUTB5-LAZRA7S-S6ZZS3S-2QNVLAA";
          };
          satama = {
            id = "DZTYQXD-3RE6PHR-QM7EE3X-DVXNEQQ-7ONTWG4-NYK4CUZ-RFVZTAV-L6MSPQJ";
          };
          koira = {
            id = "B6KWO2N-6PMBFS2-6RR7FPB-DUZDDVA-6T5YSUV-K64WG2W-VR32G4C-I3H74QW";
          };
        };
        folders = {
          ".aws" = {
            id = "m3q6z-itat6";
            label = ".aws";
            path = "/home/cig0/.aws";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          ".krew" = {
            id = "zo6vm-ycvnv";
            label = ".krew";
            path = "/home/cig0/.krew";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          ".kube" = {
            id = "cbvut-r9kxc";
            label = ".kube";
            path = "/home/cig0/.kube";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          ".ssh" = {
            id = "7cgim-4pyuc";
            label = ".ssh";
            path = "/home/cig0/.ssh";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          ".terraform.versions" = {
            id = "uoocx-gswyo";
            label = ".terraform.versions";
            path = "/home/cig0/.terraform.versions";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          "Default Folder" = {
            id = "default";
            label = "Default Folder";
            path = "/home/cig0/Sync";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          "Desktop" = {
            id = "bevao-ecdck";
            label = "Desktop";
            path = "/home/cig0/Desktop";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          "Documents" = {
            id = "4plzj-q9hjx";
            label = "Documents";
            path = "/home/cig0/Documents";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          "Downloads" = {
            id = "v72dy-fzjsf";
            label = "Downloads";
            path = "/home/cig0/Downloads";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          "KeePassXC" = {
            id = "nsqaf-gequ7";
            label = "KeePassXC";
            path = "/home/cig0/KeePassXC";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          "Pictures" = {
            id = "zhepz-tkl9u";
            label = "Pictures";
            path = "/home/cig0/Pictures";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          "stash" = {
            id = "inznp-cjdxe";
            label = "stash";
            path = "/home/cig0/stash";
            devices = [ "TUXEDOInfinityBookPro" "koira" ];
          };
          "Videos" = {
            id = "g7amc-cstmt";
            label = "Videos";
            path = "/home/cig0/Videos";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          "bin" = {
            id = "mtzdy-xgvcf";
            label = "bin";
            path = "/home/cig0/bin";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
          };
          "w" = {
            id = "rn6um-4btcp";
            label = "w";
            path = "/home/cig0/w";
            devices = [ "TUXEDOInfinityBookPro" "satama" "koira" ];
            versioning.type = "simple";
          };
        };
      };
    };
  };
}