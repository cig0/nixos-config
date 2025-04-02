{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = {
    path = config.mySystem.myOptions.environment.variables.gh;
    gh = {
      token = cfg.path.token;
      username = cfg.path.username;
    };
  };

  commonEnvSessionVars = {
    # # GitHub Access Token
    # GH_USERNAME = cfg.gh.username or "";
    # GH_TOKEN = cfg.gh.token or "";

    # Wayland/Graphics
    EGL_PLATFORM = "wayland";
    EGL_LOG_LEVEL = "fatal";

    # https://wiki.nixos.org/wiki/Wayland
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";

    # Flatpak integration (use lib.mkAfter to append)
    # GDK_DPI_SCALE = "1.13"; # Flatpak applications display scaling
    XDG_DATA_DIRS = lib.mkAfter [ "/var/lib/flatpak/exports/share" ];

    # Shell/User tools
    FZF_DEFAULT_OPTS = "--height 50% --layout=reverse --border"; # Fuzzy finder
    LD_BIND_NOW = "1"; # Linker.
    PAGER = "${pkgs.less}/bin/less"; # CLI pager
  };

  IntelGpuEnvVars = {
    EGL_DRIVER = "mesa";
    LIBVA_DRIVER_NAME = "iHD"; # Force intel-media-driver
  };

  NvidiaGpuEnvVars = {
    # Required to run the correct GBM backend for nvidia GPUs on wayland
    GBM_BACKEND = "nvidia-drm";
    # Apparently, without this nouveau may attempt to be used instead
    # (despite it being blacklisted)
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";

    # Hardware cursors are currently broken on wlroots
    WLR_NO_HARDWARE_CURSORS = "1";
  };
in
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
    environment.sessionVariables =
      commonEnvSessionVars
      // (
        if (config.mySystem.myOptions.hardware.gpu == "intel") then
          IntelGpuEnvVars
        else if (config.mySystem.myOptions.hardware.gpu == "nvidia") then
          NvidiaGpuEnvVars
        else
          { }
      );
  };
}
