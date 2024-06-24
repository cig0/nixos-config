{ ... }:

{
  services.openssh = {
    enable = true;
    # openFirewall = false; # Managed in ./firewall.nix
    listenAddresses = [
      {
        addr = "127.0.0.1";
        port = 22;
      }
      {
        addr = "100.0.0.0";
        port = 22;
      }
    ];
  };
}