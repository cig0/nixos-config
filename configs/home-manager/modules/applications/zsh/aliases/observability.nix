# Home Manager Zsh aliases module. Do not remove this header.
{
  ...
}:
let
  aliases = {
    bt = "btop";
    t = "top";
  };
in
{
  inherit aliases;
}
