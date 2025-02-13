{
  dir,
  modulesType,
}:
let
  # Construct the header line
  firstLine = "# Don't remove this line! This is a NixOS ${modulesType} module.";

  # Check if file exists and is within size limit
  isValidFile =
    file:
    let
      maxSizeBytes = 15 * 1024; # 5KB in bytes
      tryRead = builtins.tryEval (builtins.readFile file);
      fileSize = builtins.stringLength (builtins.readFile file);
    in
    tryRead.success && fileSize <= maxSizeBytes;

  # Check if the first line matches the specified criteria
  hasValidHeader =
    file:
    let
      tryContent = builtins.tryEval (builtins.readFile file);
      firstLineFromFile =
        if tryContent.success then builtins.head (builtins.split "\n" tryContent.value) else "";
    in
    tryContent.success && firstLineFromFile == firstLine;

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
        else if type == "regular" && hasSuffix ".nix" name && name != "default.nix" && isValidFile path then
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
