# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  # Trasher - https://crates.io/crates/trasher
  aliases = {
    rm = "trasher --exclude /var rm";
    rmp = "trasher --exclude /var rm -p";
    te = "trasher --exclude /var empty";
    tls = "trasher --exclude /var ls";
    tp = "trasher --exclude /var path-of";
  };

in { aliases = aliases; }