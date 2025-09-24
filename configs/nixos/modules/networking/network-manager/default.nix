{
  config,
  lib,
  self,
  ...
}:
{
  options.myNixos = {
    networking.networkmanager = {
      dns = lib.mkOption {
        type = lib.types.enum [
          "default"
          "dnsmasq"
          "systemd-resolved"
          "none"
        ];
        default = "default";
        description = ''
          Set the DNS (`resolv.conf`) processing mode.

          A description of these modes can be found in the main section of
          [
            https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html
          ](https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html)
          or in
          {manpage}`NetworkManager.conf(5)`.'';
      };

      enable = lib.mkEnableOption ''
        Whether to use NetworkManager to obtain an IP address and other
        configuration for all network interfaces that are not manually
        configured. If enabled, a group `networkmanager`
        will be created. Add all users that should have permission
        to change network settings to this group.'';

      wifi.powersave = lib.mkEnableOption "Wi-Fi power saving (can cause kernel panics).";
    };
  };

  config = lib.mkIf config.myNixos.networking.networkmanager.enable {
    # Disable wpa_supplicant to avoid conflicts with NetworkManager
    networking.wireless.enable = false;

    # Optionally wait for network availability (adjust as needed)
    systemd.network.wait-online.enable = lib.mkDefault true;

    # Configure NetworkManager
    networking.networkmanager = {
      enable = true;
      /*
        Use `nmcli connection show` to get the UUID.

        Because of how NetworkManager work, UUIDs are tied to the WiFi AP or wired connection, not
        to the interface. You will need to check with the above command once the connection is
        established to get its UUID.
      */
      # connectionFiles = {
      #   "wifi-dns-clean.nmconnection".text = ''
      #     [connection]
      #     id=wifi-dns-clean
      #     uuid=c196c532-9eb4-47a8-8df7-a353adc98744
      #     type=wifi
      #     interface-name=wlo1
      #
      #     [ipv4]
      #     method=auto
      #     ignore-auto-dns=true
      #
      #     [ipv6]
      #     method=auto
      #     ignore-auto-dns=true
      #   '';

      #   "wired-dns-clean.nmconnection".text = ''
      #     [connection]
      #     id=wired-dns-clean
      #     uuid=PUT-WIRED-UUID-HERE
      #     type=ethernet
      #     interface-name=eno2
      #
      #     [ipv4]
      #     method=auto
      #     ignore-auto-dns=true
      #
      #     [ipv6]
      #     method=auto
      #     ignore-auto-dns=true
      #   '';
      # };
      dns = config.myNixos.networking.networkmanager.dns;

      # TODO:  move to a separate module
      ensureProfiles = {
        profiles = {
          "${config.mySecrets.getSecret "shared.networking.networkmanager.ensureProfiles.profiles.profile0.name"}" =
            {
              connection = {
                id = "${config.mySecrets.getSecret "shared.networking.networkmanager.ensureProfiles.profiles.profile0.name"}";
                type = "wifi";
                autoconnect = true; # Connect automatically when in range
              };
              wifi = {
                ssid = "${config.mySecrets.getSecret "shared.networking.networkmanager.ensureProfiles.profiles.profile0.wifi.ssid"}";
              };
              wifi-security = {
                key-mgmt = "wpa-psk";
                psk =
                  "@"
                  + (config.mySecrets.getSecret "shared.networking.networkmanager.ensureProfiles.profiles.profile0.name")
                  + "-psk@"; # psk = "@PROFILE-NAME-EXAMPLE@";
              };
            };
        };

        # TODO:  support multiple profiles. This will likely requires a loop to iterate profiles names.
        secrets = {
          entries = [
            {
              key =
                (config.mySecrets.getSecret "shared.networking.networkmanager.ensureProfiles.profiles.profile0.name")
                + "-psk"; # Name of the secret, matches psk name above

              file = "${self}/secrets/shared/profile0-wifi-psk.txt"; # Path to the password file
            }
          ];
        };
      };

      settings = {
        connection = {
          # 3 = enable, 2 = disable
          "wifi.powersave" = if config.myNixos.networking.networkmanager.wifi.powersave then 3 else 2;
        };
        main = {
          # Prevent auto-connection to untrusted networks
          "no-auto-default" = "*";
        };
      };

      unmanaged = [ "tailscale0" ];
    };
  };
}
