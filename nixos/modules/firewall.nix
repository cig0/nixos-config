# Open ports in the firewall.
# Services allowed:
#   - Syncthing

{ ... }:

{
  networking = {
    nftables.enable = true; # Explicitly required by Incus

    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
      trustedInterfaces = [ "virbr0" ];
      checkReversePath = "loose";
      # The networking.firewall.checkReversePath option in NixOS controls whether the Linux kernel's
      # reverse path filtering mechanism should be enabled or not, which can enhance security by
      # preventing IP spoofing attacks but may also cause issues in certain network configurations.
    };
  };

  services = {
    openssh.openFirewall = false;
    syncthing.openDefaultPorts = true;
    tailscale.openFirewall = false;
  };
}