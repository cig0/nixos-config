{ config, ... }:

let
  mainConfig = import ../../../../modules/system/keyd.nix { inherit config; };

in {
  services.keyd = mainConfig.services.keyd // ({
    keyboards = {
      TUXEDOInfinityBookPro = {
        ids = [
          "0001:0001"
        ];
        settings = {
          main = {
            "capslock" = "capslock";
          };
          shift = {
            "capslock" = "insert";
          };
        };
      };
    };
  });
}