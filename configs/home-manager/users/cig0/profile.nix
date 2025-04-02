/*
  ░░░░░░░█▀▀░▀█▀░█▀▀░▄▀▄░▀░█▀▀░░░░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█░░░░░░░
  ░░░░░░░█░░░░█░░█░█░█/█░░░▀▀█░░░░░░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█░░░░░░░
  ░░░░░░░▀▀▀░▀▀▀░▀▀▀░░▀░░░░▀▀▀░░░░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░░░░░░░
*/
{
  config,
  nixosConfig, # Required to access NixOS configuration when using Home Manager as a module
  ...
}:
{
  home = {
    homeDirectory = "/home/cig0";

    sessionVariables = {
      GH_USERNAME = "${config.home.username}";
      GH_TOKEN = "sops-nix coming soon, i.e.: GH_TOKEN-${config.home.username}";

      # DEBUG_ Make sure this module is being integrated correctly
      PEPOTE = "PEPIN";

      EDITOR = nixosConfig.mySystem.myOptions.cli.editor;
      VISUAL = "code";
    };

    # The state version is required and should stay at the version you
    # originally installed.
    stateVersion = "24.11";
  };

  # myHM = {};
}
