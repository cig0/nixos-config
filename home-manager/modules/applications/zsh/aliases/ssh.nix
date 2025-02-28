# Don't remove this line! This is a NixOS Zsh alias module.

{ ... }:

let
  aliases = {
    sshFingerprint = "ssh-keygen -E hash_type -lf $@"; # Get key fingerprint
    sshKeygen = "ssh-keygen -t ecdsa -b 521 -N '' -f $1"; # Generate a passwordless SSH key pair suitable for non-critical chores
  };

in
{
  aliases = aliases;
}
