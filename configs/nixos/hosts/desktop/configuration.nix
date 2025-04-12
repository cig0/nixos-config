# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot = {
    initrd.luks.devices."swap".device = "/dev/disk/by-uuid/f9958b9b-9485-4a62-ab29-0b571196e660"; # Encrypted swap partition

    loader = {
      efi.canTouchEfiVariables = true;

      # Systemd-boot bootloader
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
      };
    };

    tmp.cleanOnBoot = true;
  };

  fileSystems = {
    # /etc/fstab mount options
    "/" = {
      # options = [ "commit=15" "data=journal" "discard" "errors=remount-ro" "noatime"  ];
      options = [
        "commit=15"
        "errors=remount-ro"
        "noatime"
      ];
    };
  };

  # Periodic SSD TRIM of mounted partitions in background
  services.fstrim.enable = true;

  # Set up hostname and enable networking
  networking = {
    hostName = "desktop";
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  # Nix settings
  nix = {
    settings = {
      substituters = [ "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];

      allowed-users = [
        "@builders"
        "@wheel"
      ];
      cores = 8;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      max-jobs = 8;
      trusted-users = [
        "cig0"
        "fine"
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  /*
    ░░░░░░░█▀█░█▀▄░█▀▄░▀█▀░▀█▀░▀█▀░█▀█░█▀█░█▀█░█░░░░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
    ░░░░░░░█▀█░█░█░█░█░░█░░░█░░░█░░█░█░█░█░█▀█░█░░░░░░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
    ░░░░░░░▀░▀░▀▀░░▀▀░░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░
  */

  # I removed the additional internal SSD storage, but I keep the configuration around for future use
  /*
    # Automatically mount the LUKS-encrypted internal data storage
    systemd.services.ensure-run-media-internalData-dir = {
      description = "Ensure /run/media/internalData directory exists";
      wantedBy = [ "multi-user.target" ];
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
      unitConfig.WantedBy = [ "multi-user.target" ];
    };

    environment.etc.crypttab.text = ''
      # Unlock the internal data storage as /dev/mapper/internalData
      internalData UUID=75e285f3-11c0-45f0-a3e7-a81270c22725 /root/.config/crypttab/internalData.key
    '';

    fileSystems = {

      "/run/media/internalData" = {
        device = "/dev/mapper/internalData";
        fsType = "xfs";
        label = "internalData";
        # Temporarily disable "discard": Dec 08 22:33:42 perrrkele kernel: XFS (dm-2): mounting with "discard" option, but the device does not support discard
        options = [
          "allocsize=64m"
          "defaults"
          "inode64"
          "logbsize=256k"
          "logbufs=8"
          "noatime"
          "nodiratime"
          "nofail"
          "users"
        ];
      };
      "/home/cig0/media" = {
        device = "/run/media";
        fsType = "none";
        label = "media";
        options = [ "bind" ];
      };
    };
  */
}
