{
  config,
  ...
}:
{
  mySystem = {
    # firewall.nix
    networking.firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [
        22
        3000
        8080
        8443
      ];
    };

    # gnupg.nix :: GNU GPG
    programs.gnupg.enable = true;

    # lanzaboote.nix :: Secure Boot
    boot.lanzaboote.enable = true;

    # opensshd.nix
    services.openssh = {
      enable = true;
      listenAddresses = [
        {
          # localhost
          addr = "127.0.0.1";
          port = 22;
        }
        {
          # WLAN IP address
          addr = "192.168.0.246";
          port = 22;
        }
        {
          # Tailscale's IP address
          addr = "${config.mySystem.myOptions.services.tailscale.ip}";
          port = config.mySystem.myOptions.services.tailscale.openssh.port;
        }
      ];
    };

    # sudo.nix
    security.sudo = {
      enable = true;
      extraConfig = ''
        Defaults passwd_timeout=1440, timestamp_timeout=1440
      '';
      /*
        passwd_timeout=1440, timestamp_timeout=1440:
        Extending sudo timeout this much is generally unsafe, especially on servers!
        I only enable this setting on personal devices for convenience.
      */
    };
  };
}
