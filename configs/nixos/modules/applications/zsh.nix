# Bare configuration; we're using Home Manager to fully configure Zsh.
{
  config,
  lib,
  ...
}:
{
  options.myNixos.programs.zsh.enable = lib.mkEnableOption ''
    Whether to configure zsh as an interactive shell. To enable zsh for
    a particular user, use the {option}`users.users.<name?>.shell`
    option for that user. To enable zsh system-wide use the
    {option}`users.defaultUserShell` option.
  '';

  config = {
    programs.zsh = {
      enable = config.myNixos.programs.zsh.enable || (config.myNixos.users.defaultUserShell == "zsh");
      enableBashCompletion = true;
      zsh-autoenv.enable = true;
    };
  };
}
