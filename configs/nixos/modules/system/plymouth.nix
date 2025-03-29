{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.mySystem.boot.plymouth.enable =
    lib.mkEnableOption "Enable Plymouth for a better boot experience.";

  config = lib.mkIf config.mySystem.boot.plymouth.enable {
    boot = {
      initrd.systemd.enable = true;

      kernelParams = [
        #"fbcon=nodefer"
        /*
          Purpose: Forces the framebuffer console (fbcon) to initialize immediately rather than deferring it until later in boot.
          KMS/Framebuffer Impact: Explicitly ties to framebuffer (fbcon is the framebuffer console). This can interfere with KMS taking over cleanly, as it prioritizes the legacy framebuffer console over KMS-driven output.
          Keep or Remove: Remove. It enforces framebuffer usage, which you want to avoid for pure KMS.
        */
        
        "quiet"
      ];

      plymouth.enable = true;
      plymouth.theme = "evil-nixos";
      plymouth.font = "${pkgs.fira-code}/share/fonts/truetype/FiraCode-VF.ttf";
      plymouth.themePackages = [ (pkgs.callPackage inputs.plymouth-is-underrated.outPath { }) ];
    };
  };
}
