{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixos;
in
{
  options.myNixos = {
    myOptions.services.keyd.addKeydKeyboards = lib.mkOption {
      type = lib.types.attrsOf lib.types.attrs;
      default = { };
      description = "Custom keyboard mappings for the keyd daemon.";
    };

    services.keyd = {
      enable = lib.mkEnableOption "Whether to enable keyd, a key remapping daemon.";
    };
  };

  config = lib.mkIf cfg.services.keyd.enable {
    services.keyd = {
      enable = true;
      keyboards = lib.mkMerge [
        {
          # Wireless portable keyboard
          SINOWealthGaming = {
            ids = [ "258a:002a" ];
            settings = {
              main = {
                "capslock" = "capslock";
              };
              shift = {
                "capslock" = "insert";
              };
            };
          };
        }
        # Custom keyboards from the host-options.nix
        cfg.myOptions.services.keyd.addKeydKeyboards
      ];
    };
  };
}
