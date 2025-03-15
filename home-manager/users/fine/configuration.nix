# ░░░░░░░█▀▀░▀█▀░█▀█░█▀▀░▀░█▀▀░░░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█░░░░░░░
# ░░░░░░░█▀▀░░█░░█░█░█▀▀░░░▀▀█░░░░░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█░░░░░░░
# ░░░░░░░▀░░░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░░░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░░░░░░░
{
  config,
  nixosConfig, # Required to access NixOS configuration when using Home Manager as a module
  ...
}:
{
  home = {
    homeDirectory = "/home/fine";

    sessionVariables = {
      EDITOR = nixosConfig.mySystem.myOptions.cli.editor;
      VISUAL = "code";
    };

    # The state version is required and should stay at the version you
    # originally installed.
    stateVersion = "24.11";
  };
}
