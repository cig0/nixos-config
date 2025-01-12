# TODO: Finish implementation, add description and instructions.

# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

{
  # Diff
  codif = "colordiff -y -W 212";
  d = "delta --paging=never";
  dp = "delta --paging=auto";
  dt = "difft";
}



# Check if first line matches criteria
hasValidHeader = file:
let
  content = builtins.readFile file;
  firstLine = builtins.head (builtins.split "\n" content);
in firstLine == "# Don't remove this line! This is a NixOS Zsh alias module.";

# Import all valid alias files recursively
importAliasFiles = dir:
let
  # Get all files in directory
  files = builtins.attrNames (builtins.readDir dir);
  # Filter for .nix files
  nixFiles = builtins.filter (n: builtins.match ".*\\.nix" n != null) files;
  # Create full paths
  fullPaths = map (f: dir + "/${f}") nixFiles;
  # Filter for valid headers
  validFiles = builtins.filter hasValidHeader fullPaths;
  # Import valid files and get their content
  contents = map (file: import file {}) validFiles;
  # Merge all the attribute sets
  merged = builtins.foldl' (a: b: a // b) {} contents;
in merged;

allAliases = importAliasFiles ./aliases;
