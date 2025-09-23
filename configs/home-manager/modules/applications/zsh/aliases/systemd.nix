# Home Manager Zsh aliases module. Do not remove this header.
{
  ...
}:
let
  aliases = {
    journalctl_boot_err = "journalctl -xep err -b";
  };
in
{
  inherit aliases;
}
