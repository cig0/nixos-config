{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.mySystem.boot.plymouth = {
    enable = lib.mkEnableOption "Enable Plymouth for a better boot experience.";
    theme = lib.mkOption {
      type = lib.types.enum [
        "evil-nixos"
        "bgrt"
        "spinner"
        "txt"
      ];
      default = "text";
      description = "The Plymouth theme to use.";
    };
  };

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
      plymouth.theme = config.mySystem.boot.plymouth.theme;
      plymouth.font = "${pkgs.fira-code}/share/fonts/truetype/FiraCode-VF.ttf";
      plymouth.themePackages = [ (pkgs.callPackage inputs.plymouth-is-underrated.outPath { }) ];
    };
  };
}
