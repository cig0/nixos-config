{
  # ░░░░░░░█▀▀░▀█▀░█▀▀░▄▀▄░▀░█▀▀░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
  # ░░░░░░░█░░░░█░░█░█░█/█░░░▀▀█░░░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
  # ░░░░░░░▀▀▀░▀▀▀░▀▀▀░░▀░░░░▀▀▀░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░

  myHM = {
    # Config-files
    xdg.configFile."git/config".enable = false; # Testing programs.git.config. Check for nixos/modules/applications/gix.nix.
    xdg.configFile."git/gitignore_global".enable = true;
  };
}
