{
  config,
  lib,
  ...
}:
let
  commonEnvSessionVars = {
    # Wayland/Graphics
    EGL_PLATFORM = "wayland";
    EGL_LOG_LEVEL = "fatal";

    # https://wiki.nixos.org/wiki/Wayland
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";

    # Flatpak integration (use lib.mkAfter to append)
    # GDK_DPI_SCALE = "1.13"; # Flatpak applications display scaling
    XDG_DATA_DIRS = lib.mkAfter [ "/var/lib/flatpak/exports/share" ];
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
  environment = {
    sessionVariables =
      # GPU-specific (Intel/Nvidia)
      (
        if (config.mySystem.myOptions.hardware.gpu == "intel") then
          commonEnvSessionVars // IntelGpuEnvVars
        else if (config.mySystem.myOptions.hardware.gpu == "nvidia") then
          commonEnvSessionVars // NvidiaGpuEnvVars
        else
          { }
      );
  };
}
