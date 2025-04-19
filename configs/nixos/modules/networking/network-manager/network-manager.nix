{
  config,
  lib,
  inputs,
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
      dns = config.myNixos.networking.networkmanager.dns;

      # TODO: Split/move shared profiles anywhere else--maybe modules/common?
      # Define Wi-Fi profiles shared across hosts, and reference secrets
      ensureProfiles = {
        profiles = {
          "${config.mySecrets.getSecret "networking.networkmanager.ensureProfiles.profiles.profile0.name"}" =
            {
              connection = {
                id = "${config.mySecrets.getSecret "networking.networkmanager.ensureProfiles.profiles.profile0.name"}";
                type = "wifi";
                autoconnect = true; # Connect automatically when in range
              };
              wifi = {
                ssid = "${config.mySecrets.getSecret "networking.networkmanager.ensureProfiles.profiles.profile0.wifi.ssid"}"; # Replace with your actual Wi-Fi SSID
              };
              wifi-security = {
                key-mgmt = "wpa-psk";
                psk =
                  "@"
                  + (config.mySecrets.getSecret "networking.networkmanager.ensureProfiles.profiles.profile0.name")
                  + "-psk@"; # psk = "@PROFILE-NAME-EXAMPLE@";
              };
            };
        };

        /*
          TODO: support multiple profiles
          This will likely requires a loop to iterate profiles names
        */
        # Define secrets globally
        secrets = {
          entries = [
            {
              key =
                (config.mySecrets.getSecret "networking.networkmanager.ensureProfiles.profiles.profile0.name")
                + "-psk"; # Name of the secret, matches psk name above

              file = "${inputs.self}/secrets/profile0-wifi-psk.txt"; # Path to the password file
            }
          ];
        };
      };

      settings = {
        main = {
          "no-auto-default" = "*"; # Prevent auto-connection to untrusted networks
        };
        connection = {
          "wifi.powersave" = if config.myNixos.networking.networkmanager.wifi.powersave then 3 else 2; # 3 = enable, 2 = disable
        };
      };
    };
  };
}
