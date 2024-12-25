# Import all aliases modules found in the aliases directory.

# { ... }:

# let
#   # Check if first line matches criteria
#   hasValidHeader = file:
#   let
#     content = builtins.readFile file;
#     firstLine = builtins.head (builtins.split "\n" content);
#   in firstLine == "# Don't remove this line! programs.zsh.shellInit";

#   # Get all values from an attrset, ignoring the names
#   getAllValues = attrs: builtins.foldl' (acc: name:
#     acc // (builtins.getAttr name attrs)
#   ) {} (builtins.attrNames attrs);

#   importFunctions = dir:
#     let
#       files = builtins.attrNames (builtins.readDir dir);
#       nixFiles = builtins.filter (n: builtins.match ".*\\.nix" n != null) files;
#       fullPaths = map (f: dir + "/${f}") nixFiles;
#       validFiles = builtins.filter hasValidHeader fullPaths;
#       contents = map (file: getAllValues (import file {})) validFiles;
#       merged = builtins.foldl' (a: b: a // b) {} contents;
#     in merged;


# in {
#   inherit hasValidHeader getAllValues importFunctions;
#   allFunctions = importFunctions ./functions;
# }

{ ... }:

let
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
      contents = map (file: (import file {}).function) validFiles;
      merged = builtins.concatStringsSep "\n" contents;
    in merged;

in {
  allFunctions = importFunctionFiles ./functions;
}