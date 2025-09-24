{
  ...
}:
{
  # https://stackoverflow.com/questions/76591674/nix-gives-no-space-left-on-device-even-though-nix-has-lots
  # };
  environment.variables = {
    LANG = "en_US.UTF-8";
    LANGUAGE = "en"; # Useful for GNU gettext library

    LC_ALL = "en_US.UTF-8"; # Set for consistency at early boot up to the login manager; the i18n NixOS option should be able to override it later

    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "en_US.UTF-8";

    TMPDIR = "/tmp";
  };
}
