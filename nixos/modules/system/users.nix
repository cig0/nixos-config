{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.mySystem.users.users;
in {
  options.mySystem.users.users = {
    doomguy = lib.mkEnableOption "Whether to create the testing account.";
  };

  config = {
    users.defaultUserShell = pkgs.zsh;
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
        cig0.extraGroups = ["kvm"];
        fine.extraGroups = ["kvm"];
      }
      (lib.mkIf cfg.doomguy {
        doomguy.extraGroups = ["kvm"];
      })
    ];
  };
}
