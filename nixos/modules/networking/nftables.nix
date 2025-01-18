{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "networking" "nftables"] config;
in {
  options.mySystem.networking.nftables.enable = lib.mkEnableOption "Whether to enable nftables and use nftables based firewall if enabled.
nftables is a Linux-based packet filtering framework intended to
replace frameworks like iptables.

Note that if you have Docker enabled you will not be able to use
nftables without intervention. Docker uses iptables internally to
setup NAT for containers. This module disables the ip_tables kernel
module, however Docker automatically loads the module. Please see
<https://github.com/NixOS/nixpkgs/issues/24318#issuecomment-289216273>
for more information.

There are other programs that use iptables internally too, such as
libvirt. For information on how the two firewalls interact, see
<https://wiki.nftables.org/wiki-nftables/index.php/Troubleshooting#Question_4._How_do_nftables_and_iptables_interact_when_used_on_the_same_system.3F>.";

  config = {
    networking.nftables.enable = cfg.enable; # Required by Incus.
  };
}
