{
  config,
  inputs,
  lib,
  ...
}:
let
  # TODO: add option for the secrets file name and directory
  # Read secrets file
  secrets = builtins.fromJSON (builtins.readFile "${inputs.self}/secrets/secrets.json");

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
  options.mySecrets = {
    getSecret = lib.mkOption {
      type = lib.types.functionTo lib.types.str;
      description = "Function to access secrets, returning strings or failing if missing or non-string";
    };
    raw = lib.mkOption {
      type = lib.types.attrsOf (lib.types.either lib.types.str (lib.types.attrsOf lib.types.str));
      description = "Raw secrets from secrets.json, with string or nested string attributes";
    };
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
