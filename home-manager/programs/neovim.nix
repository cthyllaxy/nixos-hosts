{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = false;
      vimAlias = true;
      preventJunkFiles = true;
      lineNumberMode = "number";

      theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
      };

      lsp = {
        enable = true;
        formatOnSave = true;
      };

      languages = {
        enableLSP = true;
        enableTreesitter = true;
        enableFormat = true;

        bash.enable = true;
        go.enable = true;
        html.enable = true;
        markdown.enable = true;
        nix = {
          enable = true;
          format = {
            package = pkgs.nixfmt-rfc-style;
            type = "nixfmt";
          };
        };
        python = {
          enable = true;
          format = {
            type = "ruff";
          };
        };
        terraform.enable = true;
      };

      filetree = {
        neo-tree.enable = true;
      };

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
      };

      spellcheck.enable = true;
      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
    };
  };
}
