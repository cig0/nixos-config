{
  config,
  lib,
  ...
}:
{
  options.mySystem.myOptions.secrets.sops-nix.enable =
    lib.mkEnableOption "Whether to enable SOPS-Nix";

  config = lib.mkIf config.mySystem.myOptions.secrets.sops-nix.enable {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      sshKeyPaths = [ "./nixos-config.pub" ];

      secrets = {
        "syncthing/cig0/password" = config.services.syncthing.settings.gui.password;
      };
    };

    #   # Example: Use the secrets in a service
    #   services.myApp = {
    #     enable = true;
    #     configFile = "/run/secrets/database/password"; # Path to decrypted secret
    #   };
  };
}
