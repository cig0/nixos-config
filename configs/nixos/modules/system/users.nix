{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixos.users.users;

  authorizedKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINedqeTiS0b8rZ3Dqm0sNevvYqkIg5ee1hWuZHDJerZq PERKELE"
  ];
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
in
{
  options.myNixos.users = {
    defaultUserShell = lib.mkOption {
      type = lib.types.enum [
        "bash"
        "zsh"
      ];
      default = "bash";
      description = ''
        This option defines the default shell assigned to user
        accounts. This can be either a full system path or a shell package.

        This must not be a store path, since the path is
        used outside the store (in particular in /etc/passwd).

        type: path or package
      '';
    };
    users = {
      doomguy = lib.mkEnableOption "Whether to create the test account.";
    };
  };

  config = {
    users.defaultUserShell = pkgs.${config.myNixos.users.defaultUserShell};

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
          extraGroups = extraGroups;
          openssh.authorizedKeys.keys = authorizedKeys;

          # Configure sub-UIDs and sub-GIDs for your user
          subUidRanges = [
            {
              startUid = 100000;
              count = 65536;
            }
          ];
          subGidRanges = [
            {
              startGid = 100000;
              count = 65536;
            }
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
          homeMode = "770"; # This is a test account, we want full access to it
          group = "users";
          extraGroups = extraGroups;
          hashedPassword = config.mySecrets.getSecret "shared.users.users.doomguy.hashedPassword";
          openssh.authorizedKeys.keys = authorizedKeys;
        };
      })
      {
        fine = {
          description = "This is fine";
          useDefaultShell = true;
          isNormalUser = true;
          createHome = true;
          home = "/home/fine";
          homeMode = "700";
          group = "users";
          extraGroups = extraGroups;
          hashedPassword = config.mySecrets.getSecret "shared.users.users.fine.hashedPassword";
          openssh.authorizedKeys.keys = authorizedKeys;
        };
      }
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

/*
  An example of a map to iterate over the users to add common options:

  let
    userMap = {
      cig0 = {
        description = "This is me";
        home = "/home/cig0";
        homeMode = "700";
      };
      fine = {
        description = "This is fine";
        home = "/home/fine";
        homeMode = "700";
      };
      doomguy = {
        description = "This is testing";
        home = "/home/doomguy";
        homeMode = "770";
      };
    };
  in
  {
    config = {
      users.users = lib.mapAttrs (name: user:
        {
          inherit (user) description home homeMode hashedPassword;
          isNormalUser = true;
          createHome = true;
          useDefaultShell = true;
          group = "users";
          extraGroups = extraGroups;
          hashedPassword = config.mySecrets.getSecret "shared.users.users.${user}.hashedPassword";
          openssh.authorizedKeys.keys = authorizedKeys;
        }
      ) userMap;
    };
  }
*/
