# Ollama server
{ config, ... }:

{
  services.ollama = {
    enable = true;
    acceleration = false; # TODO: add hostnameLogic to enable for vittu
    home = "${config.users.users.cig0.home}/.local/share/ollama";
    models = "${config.users.users.cig0.home}/ModelZoo";
    sandbox = false;
    writablePaths = [
      "${config.users.users.cig0.home}/.local/share/ollama"
      "${config.users.users.cig0.home}/ModelZoo"
    ];
  };
}