# Bare configuration; we're using Home Manager to fully configure Zsh.
{
  config,
  lib,
  ...
}:
{
  options.mySystem.programs.zsh.enable = lib.mkEnableOption ''
    Whether to configure zsh as an interactive shell. To enable zsh for
    a particular user, use the {option}`users.users.<name?>.shell`
    option for that user. To enable zsh system-wide use the
    {option}`users.defaultUserShell` option.'';

  config = {
    programs.zsh = {
      enable = config.mySystem.programs.zsh.enable || (config.mySystem.users.defaultUserShell == "zsh");
      zsh-autoenv.enable = true;
    };
  };
}
