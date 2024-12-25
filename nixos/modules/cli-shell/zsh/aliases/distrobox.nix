# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Distrobox :: https://github.com/89luca89/distrobox :: https://distrobox.it/
  aliases = {
    db = "distrobox";
    dbc = "distrobox create";
    dbe = "db enter";
    dbl = "db list";
    dbr = "db run";
  };

in {
  aliases = aliases;
}