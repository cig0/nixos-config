{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "myNixos" "system" "autoUpgrade" ] config;
in
{
  options.myNixos.system.autoUpgrade.enable =
    lib.mkEnableOption "Whether to periodically upgrade NixOS to the latest
version. If enabled, a systemd timer will run
`nixos-rebuild switch --upgrade` once a
day.";

  config = lib.mkIf cfg.enable {
    system.autoUpgrade = {
      # Since NixOS 24.05, you can also use the awesome `nh` helper tool, which I use extensibly on-demand.
      # Refs: https://search.nixos.org/options?query=nh
      enable = true;
      allowReboot = false;
      dates = "daily";
      flags = [
        "--commit-lock-file"
        "--no-build-nix"
        "--print-build-logs"
      ];
      flake = inputs.self.outPath;
      operation = "boot";
      randomizedDelaySec = "720min";
      persistent = false; # Do not try to upgrade early to compensate a missed reboot
    };
  };
}
