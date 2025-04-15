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

      # Flake source code path
      FLAKE_PATH = "${nixosConfig.myNixos.myOptions.flakePath}";

      # GitHub's `gh` CLI tool
      GH_USERNAME = "cig0";
      GH_TOKEN = "SOPS secret here, i.e.: GH_TOKEN-${config.home.username}";

      # Editor
      EDITOR = nixosConfig.myNixos.myOptions.cli.editor;
      VISUAL = "code";

      /*
        https://specifications.freedesktop.org/basedir-spec/latest/
        Publication Date: 08th May 2021, Version: Version 0.8

        Managed by `xdg.enable` (xdg.nix):
          XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache"; # `xdg.cacheHome`
          XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config"; # `xdg.configHome`
          XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share"; # `xdg.dataHome`
          XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state"; # `xdg.stateHome`
      */

      # It's handy to have this environment variable around
      XDG_HOME = "${config.home.homeDirectory}";
    };
  };
}
