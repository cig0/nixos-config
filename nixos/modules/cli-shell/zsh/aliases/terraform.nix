# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Terraform / OpenTofu
  terraform = {
    ot = "opentofu";
    tf = "terraform";
  };

in {
  terraform = terraform;
}