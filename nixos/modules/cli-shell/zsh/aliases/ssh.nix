# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # SSH commands library
  ssh = {
    sshFingerprint = "ssh-keygen -E hash_type -lf /path/to/key"; # Get key fingerprint.
  };

in {
  ssh = ssh;
}