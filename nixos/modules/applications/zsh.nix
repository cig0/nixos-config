# Don't remove this line! This is a NixOS applications module.

{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "programs" "zsh"] config;
in {
  options.mySystem.programs.zsh.enable = lib.mkEnableOption "Whether to configure zsh as an interactive shell. To enable zsh for
a particular user, use the {option}`users.users.<name?>.shell`
option for that user. To enable zsh system-wide use the
{option}`users.defaultUserShell` option.";

  config = {
    programs.zsh.enable = cfg.enable;
  };
}
# READ ME!
# ========
# Bare configuration, as we're using the Home Manager to fully configure Zsh.

