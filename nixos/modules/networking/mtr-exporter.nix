#===  MTR - https://wiki.nixos.org/wiki/Mtr
{ ... }:

{
  # services.mtr-exporter.enable = hostnameLogic.isRoleServer; # Prometheus-ready exporter.
  services.mtr-exporter.enable = false; # Prometheus-ready exporter.
}