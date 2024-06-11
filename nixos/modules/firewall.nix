{ ... }:

{
  networking = {
    nftables.enable = true; # Explicitly required by Incus

    # Open ports in the firewall.
    # Services allowed:
    #   - Syncthing: 21017 22000
    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [ 22000 ];
      allowedUDPPorts = [ 21027 22000 ];
      trustedInterfaces = [ "virbr0" ];
      checkReversePath = "loose";
      # The networking.firewall.checkReversePath option in NixOS controls whether the Linux kernel's
      # reverse path filtering mechanism should be enabled or not, which can enhance security by
      # preventing IP spoofing attacks but may also cause issues in certain network configurations.
    };
  };

  services.tailscale = {
    openFirewall = false;
    port = 41641; # Default port (0 = autoselect).
  };
}