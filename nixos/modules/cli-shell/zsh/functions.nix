# Import all function modules found in the functions directory.

{ ... }:

let
  ansiColors = import ./../ansi-colors.nix;

  # Check if first line matches criteria
  hasValidHeader = file:
    let
      content = builtins.readFile file;
      firstLine = builtins.head (builtins.split "\n" content);
    in firstLine == "# Don't remove this line! programs.zsh.shellFunctions";

  importFunctionFiles = dir:
    let
      files = builtins.attrNames (builtins.readDir dir);
      nixFiles = builtins.filter (n: builtins.match ".*\\.nix" n != null) files;
      fullPaths = map (f: dir + "/${f}") nixFiles;
      validFiles = builtins.filter hasValidHeader fullPaths;
      contents = map (file:
        let
          imported = import file { inherit ansiColors; };
        in
          if builtins.hasAttr "functions" imported
          then imported.functions
          else "") validFiles;
      merged = builtins.concatStringsSep "\n" contents;
    in merged;

in {
  allFunctions = importFunctionFiles ./functions;
}