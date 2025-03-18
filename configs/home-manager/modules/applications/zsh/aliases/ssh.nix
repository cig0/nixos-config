# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  aliases = {
    sshFingerprint = "ssh-keygen -E hash_type -lf $@"; # Get key fingerprint
    sshKeygenPasswordLess = "ssh-keygen -t ed25519 -b 521 -N '' -f $1"; # Generate a passwordless SSH key pair suitable for non-critical chores
    sshKeygenWithPassword = "ssh-keygen -t ed25519 -b 521 -f $1"; # Generate a SSH key pair with a password (asked intereactively)
  };
in
{
  aliases = aliases;
}
