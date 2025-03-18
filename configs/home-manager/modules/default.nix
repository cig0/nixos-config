{
  lib,
  ...
}:
let
  moduleLoader = import ../../../lib/module-loader.nix { inherit lib; };

  # Collect Home Manager modules
  modules = moduleLoader.collectModules {
    # Files and directories to exclude
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
