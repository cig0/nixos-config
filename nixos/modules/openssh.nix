# OpenSSH server
{ ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = false;
  };
}