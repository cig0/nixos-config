# TODO: investigate moving to Home Manager
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.mySystem.programs.nixvim;
in {
  imports = [inputs.nixvim.nixosModules.nixvim];

  options.mySystem.programs.nixvim.enable = lib.mkEnableOption "Configure Neovim with Nix!";

  config = lib.mkIf cfg.enable {
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
