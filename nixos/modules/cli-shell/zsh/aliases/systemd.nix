# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # systemd
  systemd = {
    journalctl_boot_err = "journalctl -xep err -b";
  };

in {
  systemd = systemd;
}