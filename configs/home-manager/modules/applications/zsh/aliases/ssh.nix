# Home Manager Zsh aliases module. Do not remove this header.
{
  ...
}:
let
  aliases = {
    sshFingerprint = "ssh-keygen -E hash_type -lf $@"; # Get key fingerprint
    sshKeygenPasswordLess = "ssh-keygen -t ed25519 -b 521 -N '' -f $1"; # Generate a passwordless SSH key pair suitable for non-critical chores
    sshKeygenWithPassword = "ssh-keygen -t ed25519 -b 521 -f $1"; # Generate a SSH key pair with a password (asked intereactively)

    # Hosts
    sdesktop = "ssh desktop";
    shomelabnas = "ssh homelabnas";
    sperrrkele = "ssh perrrkele";
    sterasbetoni = "ssh terasbetoni";
    tdesktop0 = "ssh desktop -t 'tmux attach-session -t 0'";
    tdesktop = "ssh desktop -t 'tmux attach-session -t'";
    thomelabnas0 = "ssh homelabnas -t 'tmux attach-session -t 0'";
    thomelabnas = "ssh homelabnas -t 'tmux attach-session -t'";
    tperrrkele0 = "ssh perrrkele -t 'tmux attach-session -t 0'";
    tperrrkele = "ssh perrrkele -t 'tmux attach-session -t'";
    tterasbetoni0 = "ssh terasbetoni -t 'tmux attach-session -t 0'";
    tterasbetoni = "ssh terasbetoni -t 'tmux attach-session -t'";
  };
in
{
  inherit aliases;
}
