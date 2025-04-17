{
  config,
  inputs,
  lib,
  ...
}:
let
  # Read secrets.json from the flake root's directory
  secrets = builtins.fromJSON (builtins.readFile "${inputs.self}/secrets.json");

  # Helper function to access secrets, failing if the key is missing
  getSecret =
    key:
    let
      path = lib.splitString "." key;
      value = lib.getAttrFromPath path secrets;
    in
    if lib.hasAttrByPath path secrets then
      if lib.isString value then value else throw "Secret '${key}' is not a string"
    else
      throw "Secret '${key}' not found in secrets.json";
in
{
  # Define options for type safety
  options.mySecrets =
    with lib;
    mkOption {
      type = types.submodule {
        options = {
          raw = mkOption {
            type = types.attrsOf (types.either types.str (types.attrsOf types.str));
            description = "Raw secrets from secrets.json, with string or nested string attributes";
          };
          getSecret = mkOption {
            type = types.functionTo types.str;
            description = "Function to access secrets, returning strings or failing if missing or non-string";
          };
        };
      };
      description = "Secrets management for the flake";
    };

  # Set mySecrets.raw and mySecrets.getSecret
  config.mySecrets = {
    raw = secrets;
    getSecret = getSecret;
  };
}

/*
      Possible transition to per-module:

  let
    secrets = {
      syncthing = builtins.fromJSON (builtins.readFile "${inputs.self}/modules/secrets/syncthing-secrets.json");
      other_module = builtins.fromJSON (builtins.readFile "${inputs.self}/modules/secrets/other-module-secrets.json");
    };
    getSecret = key: ...; # Same as above
  in
  {
    options.mySecrets = ...; # Same as above
    config.mySecrets = {
      raw = secrets;
      getSecret = getSecret;
    };
  }
*/
