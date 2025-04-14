{
  config,
  nixosConfig,
  ...
}:
{
  home = {
    sessionVariables = {
      # DEBUG: Rompé Pepe, rompé!
      PEPITO = "PEPAZO";

      FLAKE_PATH = "${nixosConfig.myNixos.myOptions.flakePath}";

      EDITOR = nixosConfig.myNixos.myOptions.cli.editor;
      VISUAL = "code";

      # https://specifications.freedesktop.org/basedir-spec/latest/
      # Publication Date: 08th May 2021, Version: Version 0.8
      XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
      XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
      XDG_HOME = "${config.home.homeDirectory}";
      XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
    };
  };
}
