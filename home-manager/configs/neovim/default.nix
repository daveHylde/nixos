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
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      vscode-langservers-extracted
      lua-language-server
      yaml-language-server
      nixd
      csharp-ls
      netcoredbg
      dockerfile-language-server-nodejs
    ];

    plugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      cmp_luasnip
      nvim-cmp
      plenary-nvim
      telescope-fzf-native-nvim
      vim-nix
      vim-csharp
      neotest-dotnet
      neotest-jest
      neotest-plenary
      lsp-zero-nvim
      luasnip
      nvim-ts-autotag
      barbar-nvim
      auto-pairs
      nvim-web-devicons
      trouble-nvim

      (pkgs.vimUtils.buildVimPlugin {
        name = "flexoki";
        src = inputs.plugin-flexoki-theme;
      })

      {
        plugin = nvim-dap-ui;
        config = toLuaFile ./plugins/dap-ui.lua;
      }

      {
        plugin = (pkgs.vimUtils.buildVimPlugin {
                    name = "cmp-bulma-nvim";
                    src = inputs.plugin-bulma-cmp;
                  });
        config = toLua "require('cmp_bulma').setup{}";
      }

      {
        plugin = (pkgs.vimUtils.buildVimPlugin {
                    name = "neotest-playwright";
                    src = inputs.plugin-neotest-playwright;
                  });
      }

      {
        plugin = (pkgs.vimUtils.buildVimPlugin {
                    name = "vim-fugitive";
                    src = inputs.plugin-vim-fugitive;
                  });
      }

      {
        plugin = nvim-colorizer-lua;
        config = toLuaFile ./plugins/colorizer.lua;
      }
 
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
