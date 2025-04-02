{
  config,
  ...
}:

{
  mySystem = {
    programs.gnupg.enable = true;
    boot.lanzaboote.enable = true;

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
          addr = "192.168.0.56";
          port = 22;
        }
        {
          #Tailscale's IP address
          addr = "${config.mySystem.myOptions.services.tailscale.ip}";
          port = config.mySystem.myOptions.services.tailscale.openssh.port;
        }
      ];
    };

    # Firewall
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

    # Sudo
    security.sudo = {
      enable = true;

      /*
        passwd_timeout=1440, timestamp_timeout=1440:
        Extending sudo timeout this much is generally unsafe, especially on servers!
        I only enable this setting on personal devices for convenience.
      */
      extraConfig = ''
        Defaults passwd_timeout=1440, timestamp_timeout=1440
      '';
    };
  };
}
