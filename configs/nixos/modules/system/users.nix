{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mySystem.users.users;
in
{
  options.mySystem.users = {
    defaultUserShell = lib.mkOption {
      type = lib.types.enum [
        "bash"
        "zsh"
      ];
      default = "bash";
      description = "This option defines the default shell assigned to user
accounts. This can be either a full system path or a shell package.

This must not be a store path, since the path is
used outside the store (in particular in /etc/passwd).

type: path or package";

    };
    users = {
      doomguy = lib.mkEnableOption "Whether to create the test account.";
    };
  };

  config = {
    users.defaultUserShell = pkgs.${config.mySystem.users.defaultUserShell};

    users.mutableUsers = true;

    users.users = lib.mkMerge [
      {
        cig0 = {
          description = "This is me";
          useDefaultShell = true;
          isNormalUser = true;
          createHome = true;
          home = "/home/cig0";
          homeMode = "700";
          group = "users";
          extraGroups = [
            "adbusers"
            "audio"
            # "corectrl"  # Enable a tool to overclock amd graphics cards and processors.
            "disk"
            "fuse"
            "incus-admin"
            "input"
            "libvirtd"
            "network"
            "networkmanager"
            "podman"
            "power"
            "samba"
            "smb"
            "sound"
            "storage"
            "systemd-journal"
            "udev"
            "users"
            "video"
            "wheel"
          ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINedqeTiS0b8rZ3Dqm0sNevvYqkIg5ee1hWuZHDJerZq PERKELE"
          ];
        };
      }
      {
        fine = {
          description = "This is fine";
          useDefaultShell = true;
          isNormalUser = true;
          createHome = true;
          home = "/home/fine";
          homeMode = "700";
          group = "users";
          extraGroups = [
            "adbusers"
            "audio"
            # "corectrl" # Enable a tool to overclock amd graphics cards and processors.
            "disk"
            "incus-admin"
            "input"
            "libvirtd"
            "network"
            "networkmanager"
            "podman"
            "power"
            "samba"
            "smb"
            "sound"
            "storage"
            "systemd-journal"
            "udev"
            "users"
            "video"
            "wheel"
          ];
          hashedPassword = "$6$DLnawxy858IxTRWn$mEV/p7ni1oh8ljvW1fQ/iI6RVhRxSqaFBtkg6qNmZ0yjVHHhWYaL9SKchFkRIpTrkNZT.sYv.75byRwaJxDJ9."; # Create a new password => mkpasswd -m sha-512
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINedqeTiS0b8rZ3Dqm0sNevvYqkIg5ee1hWuZHDJerZq PERKELE"
          ];
        };
      }
      (lib.mkIf cfg.doomguy {
        doomguy = {
          name = "doomguy";
          description = "This is testing";
          useDefaultShell = true;
          isNormalUser = true;
          createHome = true;
          home = "/home/doomguy";
          homeMode = "775"; # This is a test account, we want full access to it.
          group = "users";
          extraGroups = [
            "adbusers"
            "audio"
            # "corectrl" # Enable a tool to overclock amd graphics cards and processors.
            "disk"
            "fuse"
            "incus-admin"
            "input"
            "libvirtd"
            "network"
            "networkmanager"
            "podman"
            "power"
            "samba"
            "smb"
            "sound"
            "storage"
            "systemd-journal"
            "udev"
            "users"
            "video"
            "wheel"
          ];
          hashedPassword = "$6$DLnawxy858IxTRWn$mEV/p7ni1oh8ljvW1fQ/iI6RVhRxSqaFBtkg6qNmZ0yjVHHhWYaL9SKchFkRIpTrkNZT.sYv.75byRwaJxDJ9."; # Create a new password => mkpasswd -m sha-512
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINedqeTiS0b8rZ3Dqm0sNevvYqkIg5ee1hWuZHDJerZq PERKELE"
          ];
        };
      })
    ];

    users.extraUsers = lib.mkMerge [
      {
        cig0.extraGroups = [ "kvm" ];
        fine.extraGroups = [ "kvm" ];
      }
      (lib.mkIf cfg.doomguy {
        doomguy.extraGroups = [ "kvm" ];
      })
    ];
  };
}
