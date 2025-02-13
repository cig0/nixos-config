# Import all aliases modules found in the aliases directory.
{...}: let
  ansiColors = import ./ansi-colors.nix {};

  # Check if first line matches criteria
  hasValidHeader = file: let
    content = builtins.readFile file;
    firstLine = builtins.head (builtins.split "\n" content);
  in
    firstLine == "# Don't remove this line! This is a NixOS Zsh alias module.";

  importAliasFiles = dir: let
    files = builtins.attrNames (builtins.readDir dir);
    nixFiles = builtins.filter (n: builtins.match ".*\\.nix" n != null) files;
    fullPaths = map (f: dir + "/${f}") nixFiles;
    validFiles = builtins.filter hasValidHeader fullPaths;
    contents = map (file: let
      imported = import file {inherit ansiColors;};
    in
      if builtins.hasAttr "aliases" imported
      then imported.aliases
      else "")
    validFiles;
    merged = builtins.foldl' (a: b: a // b) {} contents;
  in
    merged;
in {
  allAliases = importAliasFiles ./aliases;
}
