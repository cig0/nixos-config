{
  imports = builtins.filter (x: x != null) [
    ./applications/default.nix
  ];
}
