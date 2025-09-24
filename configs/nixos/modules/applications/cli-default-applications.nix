{
  config,
  lib,
  ...
}:
{
  options.myNixos.myOptions.cli = {
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
    (lib.mkIf (config.myNixos.programs.nixvim.enable || lib.mkIf config.programs.neovim.enable) {
      myNixos.myOptions.cli.editor = "nvim";
    })

    # File manager configurations
    (lib.mkIf (config.myNixos.programs.yazi.enable || config.mmyNixos.ckages.yazi.enable) {
      myNixos.myOptions.cli.fileManager = "yazi";
    })
  ];
}
