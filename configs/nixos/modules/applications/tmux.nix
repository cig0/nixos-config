{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mySystem.programs.tmux = {
    enable = lib.mkEnableOption "Whenever to configure {command}`tmux` system-wide.";
    extraConfig = lib.mkOption {
      type = lib.types.str;
      description = ''
        Additional contents of /etc/tmux.conf, to be run after sourcing plugins.
        type: strings concatenated with "\n"
      '';
    };
  };

  config = lib.mkIf config.mySystem.programs.tmux.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      terminal = "tmux-direct";
      newSession = true;
      historyLimit = 20000;
      extraConfig = config.mySystem.programs.tmux.extraConfig;
    };
  };
}
