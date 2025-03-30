{
  ...
}:
{
  mySystem = {
    programs.gnupg.enable = true;
    boot.lanzaboote.enable = false;

    services.openssh = {
      enable = true;
      listenAddresses = [
        # { addr = "192.168.0.1"; } # WLAN address
        {
          addr = "127.0.0.1";
          port = 22;
        }
        {
          # This host Tailscale's IP address
          addr = "100.113.250.86";
          port = 22;
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
