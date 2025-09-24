{
  config,
  lib,
  ...
}:
{
  assertions = [
    {
      # stevenblack.nix
      assertion = lib.length config.myNixos.networking.stevenblack.block > 0;
      message = ''
        At least one category must be selected from: gambling, porn, social.

        If you want to disable all the lists, set:
          myNixos.networking.stevenblack.enable = false;
      '';
    }
  ];
}
