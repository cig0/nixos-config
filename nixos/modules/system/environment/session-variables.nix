{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = {
    cpu = config.mySystem.customOptions.hardware.cpu;
    gpu = config.mySystem.customOptions.hardware.gpu;
  };

  githubVars = {
    GITHUB_TOKEN = "WIP_OPTION"; # TODO: Implement SOPS
    GITHUB_USERNAME = "WIP_OPTION";
  };

  commonEnvSessionVars = {
    EGL_PLATFORM = "wayland";
    EGL_LOG_LEVEL = "fatal";

    # https://wiki.nixos.org/wiki/Wayland
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";

    FZF_DEFAULT_OPTS = "--height 50% --layout=reverse --border"; # Fuzzy finder
    GDK_DPI_SCALE = "1.13"; # Flatpak applications display scaling
    LD_BIND_NOW = "1"; # Linker.
    PAGER = "${pkgs.less}/bin/less"; # CLI pager

    # https://specifications.freedesktop.org/basedir-spec/latest/
    # Publication Date: 08th May 2021, Version: Version 0.8
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_HOME = "$HOME";
    XDG_STATE_HOME = "$HOME/.local/state";

    PATH = [
      "$HOME/.cargo/bin"
      "$HOME/.krew/bin"
      "$HOME/.npm_global/bin"
      "$HOME/exe"
      "$HOME/go/bin"
    ];

    # https://stackoverflow.com/questions/76591674/nix-gives-no-space-left-on-device-even-though-nix-has-lots
    TMPDIR = "/tmp";
  };

  GpuIntelEnvSessionVars = {
    LIBVA_DRIVER_NAME = "iHD"; # Force intel-media-driver
    EGL_DRIVER = "mesa";
  };
in
{
  config = {
    environment = {
      homeBinInPath = true;
      localBinInPath = true;

      pathsToLink = [ "/share/zsh" ]; # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enableCompletion

      sessionVariables =
        (
          if cfg.gpu == "intel" then
            commonEnvSessionVars // GpuIntelEnvSessionVars
          else if cfg.gpu == "nvidia" then
            commonEnvSessionVars
          else
            { }
        )
        // githubVars;
    };
  };
}
