# TODO: WIP // needs finish implementation

{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixos.services.ollama;
in
{
  options.myNixos.services.ollama = {
    enable = lib.mkEnableOption "Whether to enable Ollama local server";
    acceleration = lib.mkOption {
      type = lib.types.enum [
        null
        "false"
        "rocm"
        "cuda"
      ];
      description = "See: services.ollama.acceleration";
      default = null;
    };
  };
  config = {
    services.ollama = lib.mkIf cfg.enable {
      enable = true;
      group = "users";
      acceleration = config.myNixos.services.ollama.acceleration;
      home = "${config.users.users.cig0.home}/.local/share/ollama";
      models = "${config.users.users.cig0.home}/ModelZoo";
    };
  };
}
