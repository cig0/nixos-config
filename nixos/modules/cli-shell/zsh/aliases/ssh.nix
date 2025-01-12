# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  aliases = {
    sshFingerprint = "ssh-keygen -E hash_type -lf /path/to/key"; # Get key fingerprint.
  };

in { aliases = aliases; }