{
  ...
}:
{
  # https://stackoverflow.com/questions/76591674/nix-gives-no-space-left-on-device-even-though-nix-has-lots
  # };
  environment.variables = {
    LANG = "en_US.UTF-8";
    LANGUAGE = "en"; # Useful for GNU gettext library
    TMPDIR = "/tmp";
  };
}
