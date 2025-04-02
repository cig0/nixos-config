# WIP_ Let's leave this module around for a while until I decide if I'm going to use this settings or not
{
  lib,
  ...
}:
{
  options.mySystem.myOptions.environment.variables = {
    gh.username = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The GitHub user name to use for the CLI tool 'gh'";
    };
    gh.token = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The GitHub token to use for the CLI tool 'gh'"; # TODO_ handle with sops-nix or agenix
    };
  };

  config = {
  };
}
