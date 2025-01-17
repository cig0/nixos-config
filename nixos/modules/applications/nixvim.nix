# TODO: configure this module

{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    colorschemes.vscode.enable = true;
    opts = {
      number = true;          # Show line numbers
      relativenumber = true;  # Show relative line numbers
      shiftwidth = 2;         # Tab width should be 2
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
}