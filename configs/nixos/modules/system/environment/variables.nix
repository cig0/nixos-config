{
  ...
}:
{
  # commonEnvVars = {
  # https://specifications.freedesktop.org/basedir-spec/latest/
  # Publication Date: 08th May 2021, Version: Version 0.8
  # XDG_CACHE_HOME = "$HOME/.cache";
  # XDG_CONFIG_HOME = "$HOME/.config";
  # XDG_DATA_HOME = "$HOME/.local/share";
  # XDG_HOME = "$HOME";
  # XDG_STATE_HOME = "$HOME/.local/state";

  # https://stackoverflow.com/questions/76591674/nix-gives-no-space-left-on-device-even-though-nix-has-lots
  # };
  environment.variables = {
    LANG = "en_US.UTF-8";
    LANGUAGE = "en"; # Useful for GNU gettext library
    TMPDIR = "/tmp";
  };
}
