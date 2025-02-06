{pkgs, ...}: let
  cpuVendor = builtins.readFile (pkgs.runCommand "cpu-vendor" {} ''
    grep -m1 "vendor_id" /proc/cpuinfo | awk '{print $3}' > $out
  '');
in {
  hardware.cpu.amd.updateMicrocode = cpuVendor == "AuthenticAMD";
  hardware.cpu.intel.updateMicrocode = cpuVendor == "GenuineIntel";
}
