{
  imports = builtins.filter (x: x != null) [
    ./audio/default.nix
    ./cups.nix
    ./current-system-packages-list.nix
    ./environment/default.nix
    ./maintenance/default.nix
    ./nixos/default.nix
    ./fonts.nix
    ./hardware-acceleration.nix
    ./kernel.nix
    ./keyd.nix
    ./nix-snapd.nix
    ./ntp.nix
    ./users.nix
  ];
}
