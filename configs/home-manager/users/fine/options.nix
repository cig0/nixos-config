# ░░░░░░░█▀▀░▀█▀░█▀█░█▀▀░▀░█▀▀░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
# ░░░░░░░█▀▀░░█░░█░█░█▀▀░░░▀▀█░░░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
# ░░░░░░░▀░░░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░
{

  myHM = {
    # Config-files
    xdg.configFile."git/config".enable = false; # I'm testing programs.git.config. Check nixos/modules/applications/gix.nix for details. Learn more here [0]
    xdg.configFile."git/gitignore_global".enable = true;
  };
}

# Notes
# [0]: There's a choice to be made here. I could either use the `programs.git.config` option or the `xdg.configFile` option. The former allows for a more declarative approach, while the latter is more flexible and allows to customize Git settings (specially SSH and GPG keys) per-user. I'm leaning towards the former as I'm the only user of my systems, but I'm not sure yet. I'm leaving the door open in case I need HM's configuration flexibility.
