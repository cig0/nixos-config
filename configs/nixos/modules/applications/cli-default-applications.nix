{
  config,
  lib,
  ...
}:
{
  options.mySystem.myOptions.cli = {
    editor = lib.mkOption {
      type = lib.types.enum [
        "nvim"
        "nano"
        "vim"
      ];
      default = "nano"; # Sucks, but it comes with NixOS
      description = "The default CLI text editor.";
      example = "nvim";
    };

    fileManager = lib.mkOption {
      type = lib.types.enum [
        "yazi"
      ];
      default = "";
      description = "The default CLI file manager.";
      example = "yazi";
    };
  };

  config = lib.mkMerge [
    # Editor configurations
    (lib.mkIf config.mySystem.programs.nixvim.enable {
      mySystem.myOptions.cli.editor = "nvim";
    })
    (lib.mkIf config.programs.neovim.enable {
      mySystem.myOptions.cli.editor = "nvim";
    })

    # File manager configurations
    (lib.mkIf (config.mySystem.programs.yazi.enable || config.mySystem.packages.yazi.enable) {
      mySystem.myOptions.cli.fileManager = "yazi";
    })
  ];
}
