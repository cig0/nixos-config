{
  imports = builtins.filter (x: x != null) [
    ./configuration.nix # NixOS OG configuration file created by the installer
    ./host-options.nix # NixOS host-specific options
  ];
}
