{ config, pkgs, ... }: 

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
    '';

    extraPackages = with pkgs; [
      lua-language-server
      xclip
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      telescope-nvim
      
      (nvim-treesitter.withPlugins (p: [
	p.tree-sitter-nix
	p.tree-sitter-bash
	p.tree-sitter-lua
	p.tree-sitter-json
	p.tree-sitter-c-sharp
	p.tree-sitter-typescript
	p.tree-sitter-javascript
	p.tree-sitter-html
	p.tree-sitter-css
	p.tree-sitter-scss
	p.tree-sitter-dockerfile
	p.tree-sitter-yaml
      ]))

      vim-nix
    ];
  };
}
