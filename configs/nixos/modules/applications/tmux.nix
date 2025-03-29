{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mySystem.programs.tmux = {
    enable = lib.mkEnableOption "Whenever to configure {command}`tmux` system-wide.";
  };

  config = lib.mkIf config.mySystem.programs.tmux.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      terminal = "tmux-direct";
      newSession = true;
      historyLimit = 20000;
    };
  };
}
