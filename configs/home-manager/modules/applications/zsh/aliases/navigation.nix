# Home Manager Zsh aliases module. Do not remove this header.
{
  nixosConfig,
  ...
}:
let
  aliases = {
    # Browsers
    br = "broot --no-only-folders --no-hidden --tree --sort-by-type-dirs-first --no-whale-spotting";
    y = "yazi";

    # Directories shortcuts
    C = "cd ~/workdir/cig0";
    Cn = "cd ~/workdir/cig0/nixos";
    Cnp = "cd ~/workdir/cig0/nixpkgs";
    D = "cd ~/Downloads";
    E = "cd ~/Desktop";
    F = "cd ${nixosConfig.myNixos.myOptions.flakeSrcPath}";
    Fp = "cd ${nixosConfig.myNixos.myOptions.flakeSrcPath}-public";
    N = "cd ~/Notes";
    O = "cd ~/Documents";
    P = "cd ~/Pictures";
    S = "cd ~/Sync";
    T = "cd ~/tmp";
    W = "cd ~/workdir";

    # Session
    e = "exit";
  };
in
{
  inherit aliases;
}
