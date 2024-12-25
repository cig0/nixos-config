# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aliases = {
    # Navigation (CLI)
      e = "exit";
      jo = "joshuto";
      o = "ranger";
      y = "yazi";

      # Directories shortcuts
      D = "cd ~/Downloads";
      DA = "cd ~/data";
      DAr = "cd /run/media/data";
      DE = "cd ~/Desktop";
      DOC = "cd ~/Documents";
      F = "cd /etc/nixos/nixos-config";  # Flake directory.
      Ff = "cd ~/w/cig0/nixos/nixos-config-public";  # Public flake.
      P = "cd ~/Pictures";
      S = "cd ~/Sync";
      T = "cd ~/tmp";
      W = "cd ~/w";
  };

in {
  aliases = aliases;
}