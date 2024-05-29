# MTR -  https://wiki.nixos.org/wiki/Mtr
{ ... }:

{
  programs.mtr.enable = true;
  # services.mtr-exporter.enable = true; # Prometheus-ready exporter.
  # TODO: add logic to enable the Prometheus exporter on satama.
}
