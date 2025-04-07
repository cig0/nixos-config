# TODO_ investigate moving to Home Manager

{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mySystem.programs.nixvim.enable = lib.mkEnableOption "Configure Neovim with Nix!";

  config = lib.mkIf config.mySystem.programs.nixvim.enable {
    programs.nixvim = {
      enable = true;
      colorschemes.catppuccin.enable = true;
      colorschemes.vscode.enable = false;
      opts = {
        number = true; # Show line numbers
        relativenumber = true; # Show relative line numbers
        shiftwidth = 2; # Tab width should be 2
      };
      plugins.lualine.enable = true;

      extraPlugins = with pkgs.vimPlugins; [
        vim-nix
      ];

      extraConfigLua = ''
        -- Print a little welcome message when nvim is opened!
        print("Ready!")
      '';
    };
  };
}
