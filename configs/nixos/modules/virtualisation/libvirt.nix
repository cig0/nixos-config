{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myNixos.virtualisation.libvirtd.enable =
    lib.mkEnableOption "This option enables libvirtd, a daemon that manages
virtual machines. Users in the \"libvirtd\" group can interact with
the daemon (e.g. to start or stop VMs) using the
{command}`virsh` command line tool, among others.";

  config = lib.mkIf config.myNixos.virtualisation.libvirtd.enable {
    environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
    programs.virt-manager.enable = true;
    services.spice-vdagentd.enable = false;

    virtualisation = {
      libvirtd = {
        enable = true;
        onBoot = "ignore";
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
