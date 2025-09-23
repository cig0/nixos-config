# @MODULON_SKIP
{
  _inputs,
  myArgs,
  ...
}:
{
  nixpkgs.overlays = [ _inputs.rust-overlay.overlays.default ];

  # Additional module packages
  myNixos.myOptions.packages.modulePackages = with myArgs.packages.pkgs-unstable; [
    rust-bin.stable.latest.default
  ]; # https://github.com/oxalica/rust-overlay
}
