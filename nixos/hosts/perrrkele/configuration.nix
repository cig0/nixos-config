# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }:
{
  imports = [
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

  fileSystems = {
    # /etc/fstab mount options.
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
    hostName = "perrrkele";
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  # Nix settings
  # auto-optimise-store: the option is managed by the module nixos/modules/system/maintenance.nix
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
        "root"
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
}
