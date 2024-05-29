{ ... }:

{
  networking.nameservers = [ "82.96.65.2" "94.140.14.14" ];
  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1" "208.67.222.123" "8.8.8.8" ];
  };
}
