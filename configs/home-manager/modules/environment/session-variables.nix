{
  nixosConfig,
  ...
}:
{
  home = {
    sessionVariables = {
      # DEBUG: Rompé Pepe, rompé!
      PEPITO = "PEPAZO";

      FLAKE_PATH = "${nixosConfig.mySystem.myOptions.nixos.flakePath}";

      EDITOR = nixosConfig.mySystem.myOptions.cli.editor;
      VISUAL = "code";

      # https://specifications.freedesktop.org/basedir-spec/latest/
      # Publication Date: 08th May 2021, Version: Version 0.8
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_HOME = "$HOME";
      XDG_STATE_HOME = "$HOME/.local/state";
    };
  };
}
