# https://wiki.nixos.org/wiki/Linux_kernel
{
  config,
  lib,
  pkgs,
  ...
}:
let
  hostSelector = import ../host-selector.nix { inherit config lib; }; # TODO: remove this legacy configuration

  cfg = lib.getAttrFromPath [ "mySystem" "boot" ] config;

  kernelPackageName =
    if cfg.kernelPackages == "stable" then "linuxPackages" else "linuxPackages_" + cfg.kernelPackages;

  # Define kernel type per host, group, role, etc., e.g. `kernelPackages_isPerrrkele = "pkgs.linuxPackages_xanmod_latest";`
  # kernelPackages_isChuweiMiniPC = pkgs.linuxPackages_hardened;
  # kernelPackages_isPerrrkele = pkgs.linuxPackages_latest;
  # kernelPackages_fallback = pkgs.linuxPackages_latest;

  kernelPatches_enable = "false"; # Enable/disable applying kernel patches

  commonKernelSysctl = {
    # ref: https://wiki.archlinux.org/title/Gaming
    # ref: https://wiki.nixos.org/wiki/Linux_kernel
    "compaction_proactiveness" = false;
    "min_free_kbytes" = "1048576";
    "page_lock_unfairness" = true;
    "watermark_boost_factor" = true;
    "watermark_scale_factor" = "500";

    # ref: https://oglo.dev/tutorials/sysrq/index.html
    # ref: https://github.com/tolgaerok/nixos-kde/tree/main
    "kernel.sysrq" = 1; # SysRQ for is rebooting their machine properly if it freezes: SOURCE: https://oglo.dev/tutorials/sysrq/index.html
    "net.core.rmem_default" = 16777216; # Default socket receive buffer size, improve network performance & applications that use sockets
    "net.core.rmem_max" = 16777216; # Maximum socket receive buffer size, determin the amount of data that can be buffered in memory for network operations
    "net.core.wmem_default" = 16777216; # Default socket send buffer size, improve network performance & applications that use sockets
    "net.core.wmem_max" = 16777216; # Maximum socket send buffer size, determin the amount of data that can be buffered in memory for network operations
    "net.ipv4.tcp_keepalive_intvl" = 30; # TCP keepalive interval between probes, TCP keepalive probes, which are used to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_probes" = 5; # TCP keepalive probes, TCP keepalive probes, which are used to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_time" = 300; # TCP keepalive interval (seconds), TCP keepalive probes, which are used to detect if a connection is still alive.
    "vm.dirty_background_bytes" = 268435456; # 256 MB in bytes, data that has been modified in memory and needs to be written to disk
    "vm.dirty_bytes" = 1073741824; # 1 GB in bytes, data that has been modified in memory and needs to be written to disk
    "vm.min_free_kbytes" = 65536; # Minimum free memory for safety (in KB), can help prevent memory exhaustion situations
    "vm.swappiness" = 10; # how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM,
    "vm.vfs_cache_pressure" = 50; # Adjust vfs_cache_pressure (0-1000), how the kernel reclaims memory used for caching filesystem objects
    # A good starting value would be 50. Here's why:
    # Default (100): Balances the reclaiming of inode and dentry caches with reclaiming other memory types. This is general-purpose but can be suboptimal for workloads involving many file accesses.
    # Lower Values (<100): Favor retaining the inode and dentry caches longer, which improves file system performance by reducing disk I/O. A value of 50 strikes a reasonable balance for systems with moderate memory capacity and workloads that benefit from efficient file system operations.
    # Higher Values (>100): Increase the rate at which the kernel reclaims inode and dentry caches, which can free up memory for applications faster but might result in more frequent disk I/O. This is not ideal for a laptop used with a workload based on virtualization and programming.
  };

  commonKernelParams = [
    "fbcon=nodefer" # Prevent the kernel from blanking plymouth out of the fb
    "kvm.ignore_msrs=1"
    "kvm.report_ignored_msrs=0"
    # "logo.nologo" # Disable boot logo if any
    "mem_sleep_default=deep"
    "mitigations=auto"
    "page_alloc.shuffle=1"
    "pti=on"
    "randomize_kstack_offset=on"
    "rd.driver.pre=vfio_pci"
    "rd.luks.options=discard"
    # "rd.systemd.show_status=auto" # Disable systemd status messages
    "rd.udev.log_level=2" # Print warnings and errors during early boot.
    "udev.log_level=1" # Print error messages. Change to 2, 3 or 4 for Warning, Info and Debug messages respectively.
    # "quiet"
  ];
in
{
  options.mySystem.boot.kernelPackages = lib.mkOption {
    type = lib.types.enum [
      "latest"
      "latest_hardened"
      "lqx"
      "stable"
      "xanmod_latest"
      "xanmod_stable"
    ];
    default = "stable";
    description = "What kernel package to use.";
  };

  config = {
    boot = {
      initrd.availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ]; # Override parameter in hardware-configuration.nix
      kernelModules =
        if hostSelector.isIntelGPUHost then
          [
            "kvm-intel"
            "i915"
          ]
        else
          [ ]; # Override parameter in hardware-configuration.nix
      kernelPackages = builtins.getAttr kernelPackageName pkgs;
      # kernelPackages =
      #   if hostSelector.isChuweiMiniPC
      #   then kernelPackages_isChuweiMiniPC
      #   else if hostSelector.isPerrrkele
      #   then kernelPackages_isPerrrkele
      #   else kernelPackages_fallback; # If no specific kernel package is selected, default to NixOS latest kernel.

      kernel.sysctl =
        # net.ipv4.tcp_congestion_control: This parameter specifies the TCP congestion control algorithm to be used for managing congestion in TCP connections.
        if hostSelector.isDesktop || hostSelector.isChuweiMiniPC then
          commonKernelSysctl // { "net.ipv4.tcp_congestion_control" = "bbr"; }
        # bbr: A newer algorithm designed for higher throughput and lower latency.
        else if hostSelector.isPerrrkele then
          commonKernelSysctl // { "net.ipv4.tcp_congestion_control" = "westwood"; }
        # westwood: Aimed at improving performance over wireless networks and other lossy links by using end-to-end bandwidth estimation.
        else
          throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";

      kernelParams =
        if hostSelector.isIntelGPUHost then
          commonKernelParams
          ++ [
            "fbcon=nodefer" # Prevent the kernel from blanking plymouth out of the framebuffer.
            "fuse"
            "intel_pstate=disable"
            "i915.enable_fbc=1"
            "i915.enable_guc=2"
            "i915.enable_psr=1"
            "logo.nologo=0"
            "init_on_alloc=1"
            "init_on_free=1"
            "intel_iommu=sm_on"
            "iommu=pt"
            "mitigations=off" # Turns off certain CPU security mitigations. It might enhance performance
          ]
        else if hostSelector.isNvidiaGPUHost then
          commonKernelParams
          ++ [
            "nvidia_drm.modeset=1" # Enables kernel modesetting for NVIDIA graphics. This is essential for proper graphics support on NVIDIA GPUs.
          ]
        else
          { };

      kernelPatches =
        if kernelPatches_enable == "true" then
          [
            {
              name = "tux-logo";
              patch = null;
              extraConfig = ''
                FRAMEBUFFER_CONSOLE y
                LOGO y
                LOGO_LINUX_MONO y
                LOGO_LINUX_VGA16 y
                LOGO_LINUX_CLUT224 y
              '';
            }
          ]
        else
          [ ];
    };
  };
}
#===== REFERENCE
# kernelParams = [];
# Keyboard and Lighting:
#    tuxedo_keyboard.mode=0 (likely specific to Tuxedo brand keyboards): This argument might control the keyboard mode. Without more information about Tuxedo keyboards, it's difficult to predict the exact behavior.
#    tuxedo_keyboard.brightness=255 (likely specific to Tuxedo brand keyboards): This sets the keyboard brightness to maximum (255).
#    tuxedo_keyboard.color_left=0xff0a0a (likely specific to Tuxedo brand keyboards with RGB lighting): This sets the left-side lighting color to a shade of red (hex code #ff0a0a).
# Power Management and Memory:
#    mem_sleep_default=deep : This instructs the system to use the deepest possible sleep state for memory when inactive, potentially saving power.
#    init_on_alloc=1 & init_on_free=1: These arguments might be related to memory initialization/finalization behavior during allocation and freeing. Their specific impact depends on your kernel version and system configuration. Consult kernel documentation for details.
# Graphics (assuming you have Intel integrated graphics):
#    i915.enable_fbc=1: Enables Frame Buffer Compression (FBC) for potentially improved video memory usage.
#    i915.enable_guc=2: Enables the Graphics UCC (Unified Command Center) at level 2, potentially offering more advanced graphics features.
#                    0: If you encounter stability issues or if your workload does not benefit from GuC/HuC usage, you might disable them.
#                    1: If you want to benefit from improved graphics workload scheduling but do not need enhanced media handling.
#                    3: If you want to take advantage of both improved workload scheduling and enhanced media handling.
#    i915.enable_psr=1: Enables Panel Self Refresh (PSR) for potentially reduced power consumption by the display.
# Storage Encryption (if using LUKS):
#    rd.luks.options=discard: This tells the LUKS (Linux Unified Key Setup) encryption layer to issue discard commands to the underlying storage when blocks are freed. This can improve performance but might not be supported by all storage devices.
# Security:
#    pti=on: Enables protection against certain processor vulnerabilities (like Meltdown).
#    mitigations=auto: Enables various automated security mitigations based on your system configuration.
#    randomize_kstack_offset=on: Randomizes the kernel stack location for additional security.
# Virtualization:
#    kvm.ignore_msrs=1: Silently ignores unsupported Model-Specific Registers (MSRs) accessed by guest VMs running under KVM. This can improve performance but might mask potential issues if VMs rely on specific MSRs.
#    kvm.report_ignored_msrs=0: Prevents logging messages about ignored MSRs, reducing clutter in system logs.
#    rd.driver.pre=vfio_pci: Loads the VFIO PCI driver early during boot, crucial for GPU pass-through to VMs using VFIO.
# Memory Management:
#    page_alloc.shuffle=1: Randomizes physical memory page allocation, potentially improving security.
#    iommu=pt (with caution): Enables IOMMU pass-through for devices assigned to VMs. This can improve performance for VMs using these devices, but verify compatibility and consider using intel_iommu=sm_on instead (see below).
# Tuxedo-specific kernel paramenters
# "tuxedo_keyboard.mode=0"
# "tuxedo_keyboard.brightness=127"
# "tuxedo_keyboard.color_left=0xff0a0a"
# Nvidia
# "nvidia_drm.fbdev=1"           # Enables the use of a framebuffer device for NVIDIA graphics. This can be useful for certain configurations.
# "nvidia_drm.modeset=1"         # Enables kernel modesetting for NVIDIA graphics. This is essential for proper graphics support on NVIDIA GPUs.
