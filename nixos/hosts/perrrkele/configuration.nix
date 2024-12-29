# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [
      ./modules/security/sudo.nix  # Sudo host settings.
      ./modules/system/time.nix  # Timezone settings.
      ./hardware-configuration.nix  # Include the results of the hardware scan.
    ];


  # Complementary options for hardware-configuration.nix. Hint: run nixos-generate-config --dir ~/tmp to create a fresh set of configuration.nix and hardware-configuration.nix.
  # Bootloader
  boot = {
    initrd = {
      luks.devices."swap".device = "/dev/disk/by-uuid/edf43523-db06-4b35-9868-170c2a8ff06c";  # Encrypted swap partition.
    };

    loader = {
      efi.canTouchEfiVariables = true;

      # Systemd-boot bootloader.
      # systemd-boot.configurationLimit = 5;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
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

  fileSystems = { # /etc/fstab mount options.
    "/" = {
      # TODO: temporarily disabled due to kernel boot messages (in testing):
      # Dec 08 21:32:53 perrrkele kernel: EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!
      # Dec 08 21:32:53 perrrkele kernel: EXT4-fs (dm-0): mounting with "discard" option, but the device does not support discard
      # options = [ "commit=15" "data=journal" "discard" "errors=remount-ro" "noatime"  ];
      options = [ "commit=15" "errors=remount-ro" "noatime" ];
    };
    "/run/media/internalData" = {
      device = "/dev/mapper/internalData";
      fsType = "xfs";
      label = "internalData";
      # Temporarily disable "discard": Dec 08 22:33:42 perrrkele kernel: XFS (dm-2): mounting with "discard" option, but the device does not support discard
      options = [ "allocsize=64m" "defaults" "inode64" "logbsize=256k" "logbufs=8" "noatime" "nodiratime" "nofail" "users" ];
    };
    "/home/cig0/media" = {
      device = "/run/media";
      fsType = "none";
      label = "media";
      options = [ "bind" ];
    };
  };


  # Periodic SSD TRIM of mounted partitions in background
  services.fstrim.enable = true;


  # Nix settings
  nix = {
    settings = {
      allowed-users = [ "@builders" "@wheel" ];
      # auto-optimise-store = true; # Managed by nixos/modules/system/maintenance.nix
      cores = 4;
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = 4;
      trusted-users = [ "root" "cig0" "fine" ];
    };
  };


  # Enable networking
  networking = { # Enable networking
    hostName = "perrrkele"; # Define your hostname.
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = false; # Had to disable this feature bc it was causing issues with my wifi card (crashing randomly, mostly while the CPU was under heavy load)
    };
  };


  hardware = { # Enable bluetooth
    bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
    };
  };


  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;


  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 32;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 32;
      };
    };
    wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
          bluez_monitor.properties = {
            ["bluez5.enable-sbc-xq"] = true,
            ["bluez5.enable-msbc"] = true,
            ["bluez5.enable-hw-volume"] = true,
            ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
          }
      '')
    ];
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
