{
  pkgs,
  ...
}:
{
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
}
