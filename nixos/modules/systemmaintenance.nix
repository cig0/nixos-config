{ inputs, ... }:

{
  # Automatic system cleanup
  nix = {
    settings = {
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
      randomizedDelaySec = "720min";
    };
  };

# NixOS auto-upgrade
# See also: https://search.nixos.org/options?channel=24.05&from=0&size=50&sort=relevance&type=packages&query=programs.nh
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
      "--print-build-logs"
    ];
    flake = inputs.self.outPath;
    operation = "boot";
    randomizedDelaySec = "720min";
  };
}