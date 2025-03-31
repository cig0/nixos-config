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
      /*
        TODO_ FIX: These variables should be configurable and properly initialized after a new NixOS generation is deployed

        Unless I'm missing something, this shouldn't be sessionVariables.
      */
      EDITOR = nixosConfig.mySystem.myOptions.cli.editor;
      VISUAL = "code";
    };

    # The state version is required and should stay at the version you
    # originally installed.
    stateVersion = "24.11";
  };

  # myHM = {};
}
