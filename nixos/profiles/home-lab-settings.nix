let
  homeLabSettings = {
    # Home-lab-specific settings
    mySystem.networking.firewall.enable = false; # Assume managed by external device
    mySystem.services.ssh.enable = true;
  };
in
  homeLabSettings
