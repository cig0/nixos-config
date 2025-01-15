{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.virtualisation.libvirt;

in {
  options.mySystem.virtualisation.libvirt = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable atop, the console system performance monitor";
  };

  config = lib.mkIf (cfg == "true") {
    environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
    programs.virt-manager.enable = true;
    services.spice-vdagentd.enable = false;

    virtualisation = {
      libvirtd = {
        enable = true;
        onBoot = "ignore";
        # qemu.ovmf = {
        #   packages = [ pkgs.OVMF.fd ];
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
          runAsRoot = false;
        };
      };

      spiceUSBRedirection.enable = true;
    };
  };
}