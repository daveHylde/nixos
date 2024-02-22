{ pkgs, inputs, ... }: 

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
      vscode-langservers-extracted
      lua-language-server
      yaml-language-server
      nodePackages.vscode-json-languageserver-bin
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      nixd
      csharp-ls
      netcoredbg
    ];

    plugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      nvim-cmp
      plenary-nvim
      telescope-fzf-native-nvim
      vim-nix
      vim-csharp
      neotest-dotnet
      neotest-jest
      neotest-plenary
      lsp-zero-nvim
      {
        plugin = (pkgs.vimUtils.buildVimPlugin {
                    name = "nx-nvim";
                    src = inputs.plugin-nx-nvim;
                  });
        config = toLua "require(\"nx\").setup{ nx_cmd_root = 'npx nx', }";
      }
      {
        plugin = nvim-dap;
        config = toLuaFile ./plugins/dap.lua;
      }
      {
        plugin = neotest;
        config = toLuaFile ./plugins/neotest.lua;
      }
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugins/lsp.lua;
      }
      
      {
        plugin = toggleterm-nvim;
        config = toLuaFile ./plugins/toggleterm.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }

      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.angular
          p.bash
          p.c_sharp
          p.c
          p.dockerfile
          p.dot
          p.gitignore
          p.go
          p.javascript
          p.typescript
          p.xml
          p.java
          p.kotlin
          p.pem
          p.sql
          p.lua
          p.html
          p.css
          p.scss
          p.yaml
          p.json
          p.json5
          p.nix
          p.vim
          p.vimdoc
        ]);
        config = toLuaFile ./plugins/treesitter.lua;
      }

      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./plugins/tree.lua;
      }  
    ];
  };
}
