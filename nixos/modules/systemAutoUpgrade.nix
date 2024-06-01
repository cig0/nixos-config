{ inputs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--print-build-logs"
    ];
    dates = "daily";
    randomizedDelaySec = "720min";
  };
}
