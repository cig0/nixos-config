{
  dir,
  modulesType,
}:
let
  # Construct the header line
  firstLine = "# Don't remove this line! This is a NixOS ${modulesType} module.";

  # Check if the first line matches the specified criteria
  hasValidHeader =
    file:
    let
      content = builtins.readFile file;
      firstLineFromFile = builtins.head (builtins.split "\n" content);
    in
    firstLineFromFile == firstLine;

  # Helper function to check if a string ends with a specific suffix
  hasSuffix =
    suffix: str:
    let
      lenSuffix = builtins.stringLength suffix;
      lenStr = builtins.stringLength str;
    in
    lenStr >= lenSuffix && builtins.substring (lenStr - lenSuffix) lenSuffix str == suffix;

  # Recursively find all .nix files in a directory and its subdirectories
  findAllNixFiles =
    dir:
    let
      dirContents = builtins.readDir dir;

      # Process each entry based on its type
      processEntry =
        name: type:
        let
          path = "${dir}/${name}";
        in
        if type == "directory" then
          findAllNixFiles path
        else if type == "regular" && hasSuffix ".nix" name && name != "default.nix" then
          [ path ]
        else
          [ ];

      # Map over directory contents and concatenate results
      files = builtins.concatLists (builtins.attrValues (builtins.mapAttrs processEntry dirContents));
    in
    files;

  # Import valid modules
  importModules =
    dir:
    let
      nixFiles = findAllNixFiles dir;
      validFiles = builtins.filter hasValidHeader nixFiles;
    in
    validFiles;

  # Collect all modules from the specified directory
  allModules = importModules dir;

in
{
  imports = builtins.filter (x: x != null) allModules;
}
