{ ... }:

{
  sops = {
    defaultSopsFile = ../../sops.yaml;
    secrets = {
      "secrets.yaml" = {
        path = "../../secrets";
        restartUnits = [ "syncthing.service" ];
      };
    };
  };
}
