/*
  ░░░░░░░█▀▀░▀█▀░█▀▀░▄▀▄░▀░█▀▀░░░░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█░░░░░░░
  ░░░░░░░█░░░░█░░█░█░█/█░░░▀▀█░░░░░░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█░░░░░░░
  ░░░░░░░▀▀▀░▀▀▀░▀▀▀░░▀░░░░▀▀▀░░░░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░░░░░░░
*/
{
  config,
  ...
}:
{
  home = {
    sessionVariables = {
      GH_USERNAME = "${config.home.username}";
      GH_TOKEN = "sops-nix coming soon, i.e.: GH_TOKEN-${config.home.username}";

      # DEBUG: Make sure this module is being integrated correctly
      PEPOTE = "cig0";
    };
  };
}
