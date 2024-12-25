# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aliases = {
    sshFingerprint = "ssh-keygen -E hash_type -lf /path/to/key"; # Get key fingerprint.
  };

in {
  aliases = aliases;
}