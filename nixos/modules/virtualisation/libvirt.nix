{ pkgs, ... }:

{
  environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
  programs.virt-manager.enable = true;
  services.spice-vdagentd.enable = true;

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
}