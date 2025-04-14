# Home Manager Zsh aliases module. Do not remove this header.
{
  ...
}:
let
  # Infrastructure-as-Code
  aliases = {
    ot = "opentofu";
    tf = "terraform";
  };
in
{
  inherit aliases;
}
