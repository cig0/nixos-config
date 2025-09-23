# @MODULON_SKIP
{ _inputs, ... }:
let
  _0 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0idNvgGiucWgup/mP78zyC23uFjYq0evcWdjGQUaBH";
  _1 = "";
in
{
  imports = [ _inputs.agenix.nixosModules.default ];

  "0.age".publicKeys = [
    _0
  ];
  "1.age".publicKeys = [
    _1
  ];
}
