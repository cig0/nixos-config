# Don't remove this line! This is a NixOS applications module.

{
  config,
  lib,
  ...
}:
let
  cfg = config.mySystem.ollama;
in
{
  options.mySystem.ollama.enable = lib.mkEnableOption "Whether to enable Ollama local server";

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      group = "users";
      acceleration = false; # TODO: add hostnameLogic to enable Vittu's Nvidia GPU
      home = "${config.users.users.cig0.home}/.local/share/ollama";
      models = "${config.users.users.cig0.home}/ModelZoo";
      # home = "/home/cig0/.local/share/ollama";
      # models = "/home/cig0/ModelZoo";
    };
  };
}
