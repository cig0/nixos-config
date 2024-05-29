{ ... }:

{
  system.autoUpgrade = {
    enable = true;
    flake = "/home/cig0/.hiutale/";
    flags = [
      "--update-input"
      "nixpkgs"
      "--print-build-logs"
    ];
    dates = "daily";
    randomizedDelaySec = "720min";
  };
}
