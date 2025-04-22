{ nixpkgs }:
{
  dirs,
  excludePaths,
  extraModules,
  ...
}:
{
  imports =
    nixpkgs.lib.flatten (
      # Map over each directory and collect modules
      builtins.map (
        dir:
        let
          collector = import ./module-loader.nix { lib = nixpkgs.lib; };
          modules = collector.collectModules {
            inherit dir excludePaths;
          };
        in
        builtins.filter (x: x != null) modules
      ) dirs
    )

    # Allows importing additional modules
    ++ extraModules;
}
