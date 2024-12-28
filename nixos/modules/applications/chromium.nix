# chromium.nix - Chromium Web Browser

{ ... }:

{
  security.chromiumSuidSandbox.enable = true;
}