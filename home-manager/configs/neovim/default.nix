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
      
      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }

      plenary-nvim
      telescope-fzf-native-nvim

      {
        plugin = nvim-treesitter.withAllGrammars;
        config = toLuaFile ./plugins/treesitter.lua;
      }
      vim-nix
    ];
  };
}
