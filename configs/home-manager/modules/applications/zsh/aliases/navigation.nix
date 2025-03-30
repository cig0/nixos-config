# Home Manager Zsh aliases module. Do not remove this header.
{
  nixosConfig,
  ...
}:
let
  aliases = {
    # Navigation (CLI)
    e = "exit";
    y = "yazi";

    # Directories shortcuts
    C = "cd ~/workdir/cig0";
    D = "cd ~/Downloads";
    E = "cd ~/Desktop";
    F = "cd ${nixosConfig.mySystem.myOptions.nixos.flakePath}"; # Flake directory
    Fp = "cd ${nixosConfig.mySystem.myOptions.nixos.flakePath}-public"; # Public flake directory
    N = "cd ~/Notes";
    O = "cd ~/Documents";
    P = "cd ~/Pictures";
    S = "cd ~/Sync";
    T = "cd ~/tmp";
    W = "cd ~/workdir";
    Wcn = "cd ~/workdir/cig0/nixos";
    Wcnp = "cd ~/workdir/cig0/nixpkgs";
  };
in
{
  aliases = aliases;
}
