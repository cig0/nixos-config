{ config, lib, pkgs, ... }:

let
  hostSelector = import ../../../lib/host-selector.nix { inherit config lib; };

  # TODO: Investigate while I can't dynamically assign to the GITHUB_USERNAME variable the content of primaryUser.
  # primaryUser = builtins.getEnv "USER";
  # primaryUser = builtins.head (builtins.attrNames (lib.filterAttrs (n: v: v.isNormalUser or false) config.users.users));
  # Debug statement to verify primaryUser
  # _ = builtins.trace "Primary user: ${primaryUser}" primaryUser;

  githubVars = {
    GITHUB_TOKEN = "";  # TODO: Implement SOPS.
    # GITHUB_USERNAME = primaryUser;
    GITHUB_USERNAME = "cig0";
  };

  commonEnvSessionVars = {
    EGL_PLATFORM = "wayland";
    EGL_LOG_LEVEL = "fatal";

    # https://wiki.nixos.org/wiki/Wayland
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";

    FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border";  # Fuzzy finder.
    GDK_DPI_SCALE = "1.13"; # Flatpak applications display scaling.
    LD_BIND_NOW = "1";  # Linker.
    PAGER = "${pkgs.less}/bin/less";  # CLI pager.

    # https://specifications.freedesktop.org/basedir-spec/latest/
    # Publication Date: 08th May 2021, Version: Version 0.8
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_HOME        = "$HOME";
    XDG_STATE_HOME  = "$HOME/.local/state";

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

  intelEnvSessionVars = {
    LIBVA_DRIVER_NAME = "iHD";  # Force intel-media-driver.
    EGL_DRIVER = "mesa";
  };

in {
  imports = [
    ./console-keymap.nix  # Configure console keymap
    ./i18n.nix  # Internationalisation
  ];

  environment = {
    homeBinInPath = true;
    localBinInPath = true;

    sessionVariables =
      (if hostSelector.isIntelGPUHost then commonEnvSessionVars // intelEnvSessionVars
      else if hostSelector.isNvidiaGPUHost then commonEnvSessionVars
      else {}) // githubVars;
  };
}