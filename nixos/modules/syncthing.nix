# Syncthing shares
{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "cig0";
    group = "users";
    # configDir = "/home/cig0/.config/syncthing"; # As per NixOS options: config.services.syncthing.dataDir + "/.config/syncthing"
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
        satama = {
          id = "DZTYQXD-3RE6PHR-QM7EE3X-DVXNEQQ-7ONTWG4-NYK4CUZ-RFVZTAV-L6MSPQJ";
        };
        vittusaatana = {
          id = "B6KWO2N-6PMBFS2-6RR7FPB-DUZDDVA-6T5YSUV-K64WG2W-VR32G4C-I3H74QW";
        };
      };
      folders = {
        ".aws" = {
          id = "m3q6z-itat6";
          label = ".aws";
          path = "/home/cig0/.aws";
          devices = [ "satama" "vittusaatana" ];
        };
        ".krew" = {
          id = "zo6vm-ycvnv";
          label = ".krew";
          path = "/home/cig0/.krew";
          devices = [ "satama" "vittusaatana" ];
        };
        ".kube" = {
          id = "cbvut-r9kxc";
          label = ".kube";
          path = "/home/cig0/.kube";
          devices = [ "satama" "vittusaatana" ];
        };
        ".ssh" = {
          id = "7cgim-4pyuc";
          label = ".ssh";
          path = "/home/cig0/.ssh";
          devices = [ "satama" "vittusaatana" ];
        };
        ".terraform.versions" = {
          id = "uoocx-gswyo";
          label = ".terraform.versions";
          path = "/home/cig0/.terraform.versions";
          devices = [ "satama" "vittusaatana" ];
        };
        "Default Folder" = {
          id = "default";
          label = "Default Folder";
          path = "/home/cig0/Sync";
          devices = [ "satama" "vittusaatana" ];
        };
        "Desktop" = {
          id = "bevao-ecdck";
          label = "Desktop";
          path = "/home/cig0/Desktop";
          devices = [ "satama" "vittusaatana" ];
        };
        "Documents" = {
          id = "4plzj-q9hjx";
          label = "Documents";
          path = "/home/cig0/Documents";
          devices = [ "satama" "vittusaatana" ];
        };
        "Downloads" = {
          id = "v72dy-fzjsf";
          label = "Downloads";
          path = "/home/cig0/Downloads";
          devices = [ "satama" "vittusaatana" ];
        };
        "KeePassXC" = {
          id = "nsqaf-gequ7";
          label = "KeePassXC";
          path = "/home/cig0/KeePassXC";
          devices = [ "satama" "vittusaatana" ];
        };
        "Pictures" = {
          id = "zhepz-tkl9u";
          label = "Pictures";
          path = "/home/cig0/Pictures";
          devices = [ "satama" "vittusaatana" ];
        };
        "stash" = {
          id = "inznp-cjdxe";
          label = "stash";
          path = "/home/cig0/stash";
          devices = [ "vittusaatana" ];
        };
        "Videos" = {
          id = "g7amc-cstmt";
          label = "Videos";
          path = "/home/cig0/Videos";
          devices = [ "satama" "vittusaatana" ];
        };
        "bin" = {
          id = "mtzdy-xgvcf";
          label = "bin";
          path = "/home/cig0/bin";
          devices = [ "satama" "vittusaatana" ];
        };
        "w" = {
          id = "rn6um-4btcp";
          label = "w";
          path = "/home/cig0/w";
          devices = [ "satama" "vittusaatana" ];
          versioning.type = "simple";
        };
      };
    };
  };
}
