{
  dir,
  modulesType,
}:
let
  # Construct the header line
  firstLine = "# Don't remove this line! This is a NixOS ${modulesType} module.";

  # Check if file exists, is plain text, and is within size limit
  isValidFile =
    file:
    let
      maxSizeBytes = 16 * 1024;
      tryRead = builtins.tryEval (builtins.readFile file);

      # Check if content looks like text (no null bytes and valid UTF-8)
      isText =
        content:
        let
          # Check for null bytes (common in binary files)
          hasNullByte = builtins.match ".*\u0000.*" content != null;
          # Try to split into lines (will fail on invalid UTF-8)
          tryLines = builtins.tryEval (builtins.split "\n" content);
        in
        !hasNullByte && tryLines.success;

      fileSize = if tryRead.success then builtins.stringLength tryRead.value else 0;
    in
    if !tryRead.success then
      throw "Error: Could not read file ${file}. The file might be corrupted or not a valid text file."
    else if !isText tryRead.value then
      throw "Error: File ${file} appears to be a binary file or contains invalid text content."
    else if fileSize > maxSizeBytes then
      throw "File ${file} is too large (${toString fileSize} bytes). \nThis is a safety measure, don't panic! The current maximum allowed size is ${toString maxSizeBytes} bytes.\nYou can change it by modifying the value of the 'maxSizeBytes' variable in the 'modules-importer.nix' file."
    else
      true;

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
