# Ollama
{ ... }:

{
  services.ollama = {
    enable = true;
    acceleration = false; # perrrkele
    home = "%S/ollama";
    models = "%S/ollama/models";
    writablePaths = [ "%S/ollama" "%S/ollama/models" ];
  };
}
