# TODO: continue weeding out this file.
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    ./modules/system/keyd.nix # Keyboard mapping. Useful to re-map keys in keyboards with missing keys, e.g. the Insert key
    ./hardware-configuration.nix # Include the results of the hardware scan
  ];

  # Complementary options for hardware-configuration.nix. Hint: run nixos-generate-config --dir ~/tmp to create a fresh set of configuration.nix and hardware-configuration.nix.
  # Bootloader
  boot = {
    initrd = {
      luks.devices."swap".device = "/dev/disk/by-uuid/edf43523-db06-4b35-9868-170c2a8ff06c"; # Encrypted swap partition.
    };

    loader = {
      efi.canTouchEfiVariables = true;

      # Systemd-boot bootloader.
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        # configurationLimit = 10;
      };

      # GRUB bootloader
      grub = {
        enable = false;
        device = "nodev";
        efiSupport = true;
        # gfxmodeEfi= "text";
        # gfxmodeBios= "text";
      };
    };

    tmp.cleanOnBoot = true;
  };

  # Automatically mount the LUKS-encrypted internal data storage
  systemd.services.ensure-run-media-internalData-dir = {
    description = "Ensure /run/media/internalData directory exists";
    wantedBy = ["multi-user.target"];
    serviceConfig.ExecStart = [
      "${pkgs.bash}/bin/bash -c 'if [ ! -d /run/media/internalData ]; then ${pkgs.coreutils}/bin/mkdir -p /run/media/internalData && ${pkgs.coreutils}/bin/chown -R root:users /run/media; fi'"
    ];
    # Ensure the service runs as root
    serviceConfig.User = "root";
    serviceConfig.Group = "users";
  };

  systemd.paths.ensure-run-media-internalData-dir = {
    description = "Path unit to trigger directory creation";
    pathConfig.PathExists = "/run/media/internalData";
    unitConfig.WantedBy = ["multi-user.target"];
  };

  environment.etc.crypttab.text = ''
    # Unlock the internal data storage as /dev/mapper/internalData
    internalData UUID=75e285f3-11c0-45f0-a3e7-a81270c22725 /root/.config/crypttab/internalData.key
  '';

  fileSystems = {
    # /etc/fstab mount options.
    "/" = {
      # options = [ "commit=15" "data=journal" "discard" "errors=remount-ro" "noatime"  ];
      options = ["commit=15" "errors=remount-ro" "noatime"];
    };
    "/run/media/internalData" = {
      device = "/dev/mapper/internalData";
      fsType = "xfs";
      label = "internalData";
      # Temporarily disable "discard": Dec 08 22:33:42 TUXEDOInfinityBookPro kernel: XFS (dm-2): mounting with "discard" option, but the device does not support discard
      options = ["allocsize=64m" "defaults" "inode64" "logbsize=256k" "logbufs=8" "noatime" "nodiratime" "nofail" "users"];
    };
    "/home/cig0/media" = {
      device = "/run/media";
      fsType = "none";
      label = "media";
      options = ["bind"];
    };
  };

  # Periodic SSD TRIM of mounted partitions in background
  services.fstrim.enable = true;

  # Set up hostname and enable networking
  networking = {
    hostName = "TUXEDOInfinityBookPro";
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  # Nix settings
  # auto-optimise-store: the option is managed by the module nixos/modules/system/maintenance.nix
  nix = {
    settings = {
      allowed-users = ["@builders" "@wheel"];
      cores = 4;
      experimental-features = ["nix-command" "flakes"];
      max-jobs = 4;
      trusted-users = ["root" "cig0" "fine"];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
