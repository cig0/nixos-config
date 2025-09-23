{
  config,
  lib,
  self,
  ...
}:
let
  # Read secrets files
  secrets = {
    host = builtins.fromJSON (builtins.readFile "${self}/${config.mySecrets.secretsFile.host}");
    shared = builtins.fromJSON (builtins.readFile "${self}/${config.mySecrets.secretsFile.shared}");
  };

  getSecret =
    key:
    let
      path = lib.splitString "." key;
      value = lib.getAttrFromPath path secrets;
    in
    if lib.hasAttrByPath path secrets then
      if
        /*
          Validate that the secret value is one of the following types:
          - A port number (integer between 0-65535)
          - A list of port numbers (each an integer between 0-65535)
          - A string (for passwords, keys, hostnames, etc.)

          This provides basic type safety helping catch typos in keys or incorrect data types.
        */
        (lib.isInt value && value >= 0 && value <= 65535)
        || (builtins.isList value && builtins.all (x: lib.isInt x && x >= 0 && x <= 65535) value)
        || lib.isString value
      then
        value
      else
        throw "Secret '${key}' is not a 32-bit integer, a list of 32-bit integers, or a string"
    else
      throw "Secret '${key}' not found.";
in
{
  # Define options for type safety
  options.mySecrets = {
    getSecret = lib.mkOption {
      type = lib.types.functionTo (
        lib.types.either (lib.types.either lib.types.port lib.types.str) (lib.types.listOf lib.types.int)
      );
      description = "Function to access secrets, returning strings or failing if missing or non-string";
    };
    raw = lib.mkOption {
      type = lib.types.attrsOf (lib.types.either lib.types.str (lib.types.attrsOf lib.types.str));
      description = "Raw secrets from secrets.json, with string or nested string attributes";
    };
    secretsFile = {
      host = lib.mkOption {
        type = lib.types.str;
        description = "Path to host secrets file";
      };
      shared = lib.mkOption {
        type = lib.types.str;
        description = "Path to shared secrets file";
      };
    };
  };

  # Set mySecrets.raw and mySecrets.getSecret
  config = {
    mySecrets = {
      raw = secrets;
      getSecret = getSecret;
    };
  };
}
