# TODO_ investigate moving to Home Manager

{ config, lib, pkgs, ... }: {
  options.mySystem.programs.nixvim.enable =
    lib.mkEnableOption "Configure Neovim with Nix!";

  config = lib.mkIf config.mySystem.programs.nixvim.enable {
    programs.nixvim = {
      enable = true;
      colorschemes.catppuccin.enable = false;
      colorschemes.vscode.enable = true;

      # Auto-format Nix files on save
      autoCmd = [{
        event = [ "BufWritePre" ];
        pattern = "*.nix";
        callback = {
          __raw = ''
            function()
              vim.lsp.buf.format({ async = false })
            end
          '';
        };
      }];

      keymaps = [
        {
          key = "<leader>e";
          action = "<cmd>Neotree<CR>"; # or Neotree
          mode = "n";
          options.desc = "Explorer (file tree)";
        }
        {
          mode = "n";
          key = "<leader>d";
          action = ":t.<CR>";
          options = {
            silent = true;
            noremap = true;
          };
        }
        {
          mode = [ "n" "v" ];
          key = "<A-Up>";
          action = "<cmd>m '<-2<CR>gv=gv"; # Move line/selection UP
          options = { silent = true; };
        }
        {
          mode = [ "n" "v" ];
          key = "<A-Down>";
          action = "<cmd>m '>+1<CR>gv=gv"; # Move line/selection DOWN
          options = { silent = true; };
        }
      ];

      opts = {
        clipboard = "unnamedplus";
        number = true; # Show line numbers
        relativenumber = true; # Show relative line numbers
        shiftwidth = 2; # Tab width should be 2
      };

      plugins = {
        # alpha.enable = true;
        # chadtree.enable = true;
        dashboard.enable = true;
        lualine.enable = true;
        neo-tree.enable = true;
        none-ls = {
          enable = true;
          sources.formatting.nixfmt.enable =
            true; # Uses nixfmt-rfc-style from PATH
        };
        telescope.enable = true;
        web-devicons.enable = false;
      };

      extraPlugins = with pkgs.vimPlugins; [ vim-nix ];

      extraConfigLua = ''
        vim.g.mapleader = " "  -- Sets the leader key to space

        -- Print a little welcome message when nvim is opened!
        print("Ready!")
      '';
    };
  };
}
