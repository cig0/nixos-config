# ░░░░░░█▀▀░▀█▀░█▀▀░▄▀▄░▀░█▀▀░░░░░░█▀█░█▀█░█▀▀░█░█░█▀█░█▀▀░█▀▀░█▀▀░░░░░░
# ░░░░░░█░░░░█░░█░█░█/█░░░▀▀█░░░░░░█▀▀░█▀█░█░░░█▀▄░█▀█░█░█░█▀▀░▀▀█░░░░░░
# ░░░░░░▀▀▀░▀▀▀░▀▀▀░░▀░░░░▀▀▀░░░░░░▀░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░░░░
{
  pkgs,
  pkgsUnstable,
  ...
}:
{

  home = {
    packages =
      with pkgs;
      [
      ]
      ++ (with pkgsUnstable; [
        # Web
        # (pkgsUnstable.wrapFirefox (pkgsUnstable.firefox-unwrapped.override { pipewireSupport = true;}) {})
      ]);
  };
}
