{ config, lib, ... }:

let
  cfg = config.mySystem.programs.nix-index-database.comma;

in {
  options.mySystem.programs.nix-index-database.comma = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable using comma for nix-index-database";
  };

  config = lib.mkIf (cfg == "true") {
    programs.nix-index-database.comma.enable = true;
  };
}