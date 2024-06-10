{ ... }:

{
  nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  programs.chromium.enablePlasmaBrowserIntegration = true;
  security.chromiumSuidSandbox.enable = true;
}