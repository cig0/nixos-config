# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  # Terraform / OpenTofu
  aliases = {
    ot = "opentofu";
    tf = "terraform";
  };
in
{
  aliases = aliases;
}
