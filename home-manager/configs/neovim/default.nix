{ pkgs, inputs, ... }:

{
	programs.neovim = let
		toLua = str: "lua << EOF\n${str}\nEOF\n";
	  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
	in {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;

		extraLuaPackages = luaPkgs: with luaPkgs; [
				lua-curl
				lua-lsp
				luarocks
				luarocks-nix
				magick
				mimetypes
				rest-nvim
				rocks-nvim
				xml2lua
		  	jsregexp
		];
		extraPackages = with pkgs; [
			chafa
			fd
			file
			gcc
			lua-language-server
			python3Full
			ripgrep
			wget
			xclip
			nixd
			netcoredbg
		];

		extraLuaConfig = ''
  	${builtins.readFile ./nvim/options.lua}
		${builtins.readFile ./nvim/keymaps.lua}
		${builtins.readFile ./nvim/autocmds.lua}
		'';

		plugins = with pkgs.vimPlugins; [
			cmp-nvim-lsp
			cmp_luasnip
			friendly-snippets
			lazygit-nvim
			lualine-nvim
			luasnip
			nui-nvim
			nvim-web-devicons
			which-key-nvim
			plenary-nvim
			telescope-fzf-native-nvim
			telescope-media-files-nvim
			telescope-live-grep-args-nvim
			vim-tmux-navigator
			csharpls-extended-lsp-nvim
			FixCursorHold-nvim
			neotest-dotnet
			neotest-playwright
			cmp-path
			nvim-dap-ui

      (pkgs.vimUtils.buildVimPlugin {
        name = "tailwindcss-colorizer-cmp";
        src = inputs.plugin-tailwindcss-colorizer-cmp;
      })

      (pkgs.vimUtils.buildVimPlugin {
        name = "nx-nvim";
        src = inputs.plugin-nx;
      })

			{
					plugin = nvim-dap;
					config = toLuaFile ./nvim/plugins/dap.lua;
			}
			{
				plugin = neotest;
				config = toLuaFile ./nvim/plugins/neotest.lua;
			}
			{
				plugin = lualine-nvim;
				config = toLua "require(\"lualine\").setup()";
			}
			{
				plugin = tailwindcss-colors-nvim;
				config = toLua "require(\"tailwindcss-colors\").setup()";
			}
			{
				plugin = bufferline-nvim;
				config = toLua "require(\"bufferline\").setup()";
			}
			{
				plugin = actions-preview-nvim;
				config = toLuaFile ./nvim/plugins/actions-preview.lua;
			}
			{
				plugin = gitsigns-nvim;
				config = toLua "require(\"gitsigns\").setup()";
			}
			{
				plugin = which-key-nvim;
				config = toLua "require(\"which-key\").setup()";
			}
			{
				plugin = mason-nvim;
				config = toLua "require(\"mason\").setup()";
			}
			{
				plugin = mason-tool-installer-nvim;
				config = toLuaFile ./nvim/plugins/mason.lua;
			}
			{
				plugin = image-nvim;
				config = toLuaFile ./nvim/plugins/image.lua;
			}
			{
				plugin = (nvim-treesitter.withPlugins (p: [
						p.tree-sitter-angular
						p.tree-sitter-bash
						p.tree-sitter-c_sharp
						p.tree-sitter-css
						p.tree-sitter-c
						p.tree-sitter-csv
						p.tree-sitter-dockerfile
						p.tree-sitter-gitignore
						p.tree-sitter-html
						p.tree-sitter-http
						p.tree-sitter-javascript
						p.tree-sitter-json
						p.tree-sitter-json5
						p.tree-sitter-lua
						p.tree-sitter-nix
						p.tree-sitter-python
						p.tree-sitter-sql
						p.tree-sitter-tmux
						p.tree-sitter-toml
						p.tree-sitter-typescript
						p.tree-sitter-vim
						p.tree-sitter-yaml
				]));
		  config = toLuaFile ./nvim/plugins/treesitter.lua;
		}
		{
			plugin = gruvbox-nvim;
			config = "colorscheme gruvbox";
		}
		{
			plugin = comment-nvim;
			config = toLua "require(\"Comment\").setup()";
		} 
		{
			plugin = neo-tree-nvim;
			config = toLuaFile ./nvim/plugins/neotree.lua;
		} 
		{
			plugin = telescope-nvim;
			config = toLuaFile ./nvim/plugins/telescope.lua;
		}
		{
			plugin = nvim-cmp;
			config = toLuaFile ./nvim/plugins/cmp.lua;
		}
		{
			plugin = nvim-lspconfig;
			config = toLuaFile ./nvim/plugins/lsp.lua;
		}
		];
	};
}
