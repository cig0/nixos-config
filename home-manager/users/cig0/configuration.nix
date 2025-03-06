{
  config,
  inputs,
  lib,
  ...
}:
{
  # ░░░░░░█▀▀░▀█▀░█▀▀░▄▀▄░▀░█▀▀░░░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█░░░░░░
  # ░░░░░░█░░░░█░░█░█░█/█░░░▀▀█░░░░░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█░░░░░░
  # ░░░░░░▀▀▀░▀▀▀░▀▀▀░░▀░░░░▀▀▀░░░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░░░░░░

  home = {
    homeDirectory = "/home/cig0";

    sessionVariables = {
      EDITOR = config.mySystem.cli.editor;
      VISUAL = "code";
    };

    # packages = with pkgs;
    #   [
    #   ]
    #   ++ (with pkgsUnstable; [
    #     # Web
    #     # (pkgsUnstable.wrapFirefox (pkgsUnstable.firefox-unwrapped.override { pipewireSupport = true;}) {})
    #   ]);

    # The state version is required and should stay at the version you
    # originally installed.
    stateVersion = "24.11";
  };
}
