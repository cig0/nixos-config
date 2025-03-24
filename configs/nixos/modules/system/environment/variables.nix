/*
  TODO: (SPIKE) error: file 'nixos-config' was not found in the Nix search path (add it using $NIX_PATH or -I)
  - Investigate if it's necessary/useful to add the flake path to the NIX_PATH environment variable.

  TODO:
  Investigate moving user-related environment variables to Home Manager.

  The wiki mentions that this might not be needed, though, as refreshing the
  environment variables should be as easy reloading the shell session, for which
  I already have a function zr().

  https://wiki.nixos.org/wiki/Environment_variables#Configuration_of_shell_environment_on_NixOS

  # environment.sessionVariables
  A set of environment variables used in the global environment.
  These variables will be set by PAM early in the login process.

  The value of each session variable can be either a string or a
  list of strings. The latter is concatenated, interspersed with
  colon characters.

  Note, due to limitations in the PAM format values may not
  contain the `"` character.

  Also, these variables are merged into
  [](#opt-environment.variables) and it is
  therefore not possible to use PAM style variables such as
  `@{HOME}`.

  type: attribute set of ((list of (signed integer or string or path)) or signed integer or string or path)
*/
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Conditionals
  cfg = {
    path = config.mySystem.myOptions.environment.variables.gh;
    gh = {
      token = cfg.path.token;
      username = cfg.path.username;
    };
  };
  isIntelGpu = config.mySystem.myOptions.hardware.gpu == "intel";
  isNvidiaGpu = config.mySystem.myOptions.hardware.gpu == "nvidia";

  # Variables definitions
  githubVars =
    lib.optionalAttrs (cfg.gh.username != null) {
      GITHUB_USERNAME = cfg.gh.username;
    }
    // lib.optionalAttrs (cfg.gh.token != null) {
      GITHUB_TOKEN = cfg.gh.token; # TODO: Implement SOPS or Agenix
    };

  commonEnvVars = {
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
      description = "The GitHub token to use for the CLI tool 'gh'"; # TODO: handle with nix-sops or agenix
    };
  };

  config = {
    environment = {
      homeBinInPath = true;
      localBinInPath = true;

      pathsToLink = [ "/share/zsh" ]; # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enableCompletion

      variables =
        (
          if isIntelGpu then
            commonEnvVars // IntelGpuEnvVars
          else if isNvidiaGpu then
            commonEnvVars
          else
            { }
        )
        // githubVars;
    };
  };
}
