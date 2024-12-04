{ ... }:

{
  services.ollama = {
    enable = true;
    group = "users";
    acceleration = false; # TODO: add hostnameLogic to enable Vittu's Nvidia GPU
    # home = "${config.users.users.cig0.home}/.local/share/ollama";
    # models = "${config.users.users.cig0.home}/ModelZoo";
    home = "/home/cig0/.local/share/ollama";
    models = "/home/cig0/ModelZoo";
  };
}
