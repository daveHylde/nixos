{ config, pkgs, inputs, ... }: 

{
  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./mappings.lua}
    '';


    extraPackages = with pkgs; [
      lua-language-server
      xclip
      ripgrep
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig 
      plenary-nvim
      telescope-fzf-native-nvim
      vim-nix

      {
        plugin = toggleterm-nvim;
        config = toLuaFile ./plugins/toggleterm.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }

      {
        plugin = nvim-treesitter.withAllGrammars;
        config = toLuaFile ./plugins/treesitter.lua;
      }

      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./plugins/tree.lua;
      }
    ];
  };
}
