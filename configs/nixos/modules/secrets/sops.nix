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
        # example-secret.mode = "0440";
        # example-secret.owner = config.users.users.nobody.name;
        # example-secret.group = config.users.users.users.group;
        "cig0/github/gh_token" = { };
      };
    };

    #   # Example: Use the secrets in a service
    #   services.myApp = {
    #     enable = true;
    #     configFile = "/run/secrets/database/password"; # Path to decrypted secret
    #   };
  };
}
