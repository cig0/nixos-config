{
  lib,
  ...
}:
let
  moduleLoader = import ../../../lib/module-loader.nix { inherit lib; };

  # Get the directory of this file
  dir = ./.;

  # Collect all home-manager modules
  modules = moduleLoader.collectModules {
    inherit dir;
    excludePaths = [
      "applications/zsh"
    ];
  };
in
{
  imports = builtins.filter (x: x != null) modules ++ [
    ./applications/zsh/zsh.nix # Temporary workaround
  ];
}
