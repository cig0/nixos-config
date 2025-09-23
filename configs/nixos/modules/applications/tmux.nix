{
  config,
  lib,
  myArgs,
  ...
}:
{
  options.myNixos = {
    myOptions = {
      packages.tmux = {
        enable = lib.mkEnableOption ''
          Whether to configure `tmux` system-wide installed from packages.
        '';
      };
    };

    programs.tmux = {
      enable = lib.mkEnableOption ''
        Whether to configure {command}`tmux` system-wide installed through NixOS options.
      '';
      extraConfigBeforePlugins = lib.mkOption {
        type = lib.types.str;
        description = ''
          Additional contents of /etc/tmux.conf, to be run after sourcing plugins.
          type: strings concatenated with "\n"
        '';
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.myNixos.programs.tmux.enable {
      programs.tmux = {
        enable = true;
        clock24 = true;
        extraConfigBeforePlugins =
          ''
            set -g status-right "\"#H\""  # Just show the hostname
          ''
          + (config.myNixos.programs.tmux.extraConfigBeforePlugins or "");
        historyLimit = 20000;
        newSession = true;
        secureSocket = true;
        terminal = "tmux-direct";
      };
    })

    (lib.mkIf config.myNixos.myOptions.packages.tmux.enable {
      myNixos.myOptions.packages.modulePackages = with myArgs.packages.pkgs; [ tmux ];

      environment.etc."tmux.conf".text = ''
        new-session
        set  -g default-terminal  "tmux-direct"
        set  -g base-index        0
        setw -g pane-base-index   0
        set  -g history-limit     20000
        set -g status-keys        emacs
        set -g mode-keys          emacs
        setw -g aggressive-resize off
        setw -g clock-mode-style  24
        set  -s escape-time       500
        set -g status-right       "\"#H\""  # Just show the hostname
        set -g status-style       bg=colour26,fg=white # Move to myNixos.myOption 
      '';
    })
  ];
}
