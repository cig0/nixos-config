# Don't remove this line! This is a NixOS applications module.

{ config, lib, ... }:
{
  # ░░░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
  # ░░░░░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
  # ░░░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░
  options.mySystem = {
    cli = {
      editor = lib.mkOption {
        type = lib.types.str;
        default =
          let
            # List of editors in priority order
            editors = [
              {
                name = "nvim";
                enabled = config.programs.nixvim.enable;
              }
              {
                name = "nvim";
                enabled = config.programs.neovim.enable;
              }
              {
                name = "vim";
                enabled = config.programs.vim.enable;
              }
            ];
            # Find the first enabled editor
            selectedEditor = builtins.head (builtins.filter (editor: editor.enabled == true) editors);

            # Generate a dynamic warning message listing all available editors
            editorNames = builtins.concatStringsSep ", " (
              builtins.unique (builtins.map (editor: editor.name) editors)
            );
            warningMessage = "Warning: No CLI editor configured (${editorNames})!";
          in
          if selectedEditor != null then
            selectedEditor.name
          else if config.programs.nixvim.enable != null && config.programs.nixvim.enable != true then
            builtins.trace "Warning: NixVim NixOS option is configured but not set to 'true'!" null
          else
            builtins.trace warningMessage null;
        description = "The default CLI text editor.";
      };

      fileManager = {
        type = lib.types.str;
        default =
          if config.programs.yazi.enable then
            "yazi"
          else
            builtins.trace "Warning: Yazi NixOS option not enabled!" null;
        description = "The default CLI file manager.";
      };
    };
  };
}
