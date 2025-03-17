# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  aliases = {
    p = "python";
    vac = ". .venv/bin/activate";
    vde = "deactivate";
  };
in
{
  aliases = aliases;
}
