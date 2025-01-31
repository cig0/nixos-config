# Don't remove this line! This is a NixOS Zsh alias module.
{...}: let
  aliases = {
    p = "python";
    vac = ". .venv/bin/activate";
    vde = "deactivate";
  };
in {aliases = aliases;}
