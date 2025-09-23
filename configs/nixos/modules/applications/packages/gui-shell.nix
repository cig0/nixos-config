# @MODULON_SKIP
# Set of packages for all hosts
# This file is extracted from packages.nix to improve modularity and maintainability.
{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  # cosmic = with pkgs; [
  # ];
  # hyprland = with pkgs; [
  # ];
  kde = with pkgs; [
    kdePackages.alpaka
    kdePackages.discover
    kdePackages.kdenlive
    kdePackages.kio-zeroconf
    kdePackages.kjournald
    kdePackages.krohnkite
    kdePackages.kup
    kdePackages.kwallet-pam
    kdePackages.partitionmanager
    kdePackages.plasma-browser-integration
    kdePackages.yakuake
    krita
    krita-plugin-gmic

    # Dependencies / helpers
    aha # Required for "About this System" in System Settings.
    glaxnimate # Kdenlive dependency
  ];
  # wayfire = with pkgs; [
  # ];
  # xfce = with pkgs; [
  # ];
}
