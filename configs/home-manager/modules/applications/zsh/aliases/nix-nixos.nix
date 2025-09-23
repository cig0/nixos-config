# Home Manager Zsh aliases module. Do not remove this header.
{
  nixosConfig,
  ...
}:
let
  aliases = {
    # Build NixOS generation
    # These aliases leverages the `nhos` function I created for nh; see `../functions/nix-nixos.nix`
    nhosb = "nhos boot";
    nhosbOSF = "nhos boot -- --option substitute false"; # Network access disabled
    nhosbd = "nhos boot --dry";
    nhosbdOSF = "nhos boot --dry -- --option substitute false"; # Network access disabled
    nhoss = "nhos switch";
    nhossOSF = "nhos switch -- --option substitute false"; # Network access disabled
    nhossd = "nhos switch --dry";
    nhossdOSF = "nhos switch --dry -- --option substitute false"; # Network access disabled

    # Cleaning
    nhcak3 = "nh clean all --keep 3 && nix store optimise --verbose";
    nhcak3b = "nh clean all --keep 3 && nix store optimise --verbose && nhosb";
    nhcuk3 = "nh clean user --keep 3 && nix store optimise --verbose";
    nixcg3 = "nix-collect-garbage -d 3";

    # Flakes
    nixfc = "nix flake check";

    /*
      Since `nh` doesn't pass arguments to `nix` (only to `build`, as in `nix build`), I had to move
      away from `nh os {action} --update` to nix in order to authenticate against GitHub using the
      .netrc method before updating the local cache.
    */
    nixfu = "nix --option netrc-file ~/.netrc flake update --flake ${nixosConfig.myNixos.myOptions.flakeSrcPath} --verbose";

    # Search (options and packages)
    nhs = "nh search --channel nixos-25.05";
    nhsu = "nh search --channel nixos-unstable";
    nixs = "nix search nixpkgs";
    nixsu = "nix search nixpkgs/nixos-unstable#";

    # System
    nixinfo = "nix-info --host-os -m";
    nixlg = "nixos-rebuild list-generations";
  };
in
{
  inherit aliases;
}
