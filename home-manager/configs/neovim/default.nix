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
		#		package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

		extraLuaPackages =  luaPkgs: with pkgs.luajitPackages; [
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
			wl-clipboard
			marksman
			sox
			dwt1-shell-color-scripts
		];

		extraLuaConfig = ''
  	${builtins.readFile ./nvim/options.lua}
		${builtins.readFile ./nvim/keymaps.lua}
		${builtins.readFile ./nvim/autocmds.lua}
		'';

		plugins = with pkgs.vimPlugins; [
			markdown-preview-nvim
			advanced-git-search-nvim
			FixCursorHold-nvim
			SchemaStore-nvim
			cmp-buffer
			cmp-nvim-lsp
			cmp-path
			cmp_luasnip
			cmp-nvim-lsp-signature-help
			editorconfig-nvim
			friendly-snippets
			lualine-nvim
			luasnip
			lspkind-nvim
			neotest-dotnet
			nvim-web-devicons
			nvim-nio
			mini-icons
			plenary-nvim
			popup-nvim
			telescope-fzf-native-nvim
			telescope-live-grep-args-nvim
			telescope-ui-select-nvim
			telescope-media-files-nvim
			undotree
			vim-dadbod
			vim-dadbod-completion
			vim-dadbod-ui
			vim-dotenv
			vim-fugitive
			vim-matchup
			vim-tmux-navigator
			which-key-nvim
			colorizer
			nui-nvim

		  # From source
			{
				plugin = nvim-lspconfig;
				config = toLuaFile ./nvim/plugins/lsp.lua;
			}
			{
				plugin = (pkgs.vimUtils.buildVimPlugin {
					name = "tailwind-tools";
					src = inputs.plugin-tailwind-tools;
				});
				config = toLuaFile ./nvim/plugins/tailwind-tools.lua;
			}
			{
				plugin = (pkgs.vimUtils.buildVimPlugin {
					name = "nx-nvim";
					src = inputs.plugin-nx;
				});
				config = toLuaFile ./nvim/plugins/nx.lua;
			}
			{
				plugin = (pkgs.vimUtils.buildVimPlugin {
					name = "rzls";
					src = inputs.plugin-rzls;
				});
				config = toLuaFile ./nvim/plugins/rzls.lua;
			}
			{
				plugin = (pkgs.vimUtils.buildVimPlugin {
					name = "roslyn";
					src = inputs.plugin-roslyn-lsp;
				});
				config = toLuaFile ./nvim/plugins/roslyn.lua;
			}

			# With config
			{ 
				plugin = nvim-dap-ui;
				config = toLuaFile ./nvim/plugins/dapui.lua;
			}
			{ 
				plugin = (pkgs.vimUtils.buildVimPlugin {
					name = "conform";
					src = inputs.plugin-conform;
				});
				config = toLuaFile ./nvim/plugins/conform.lua;
			}
			{ 
				plugin = (pkgs.vimUtils.buildVimPlugin {
					name = "gp";
					src = inputs.plugin-gp;
				});
				config = toLuaFile ./nvim/plugins/gp.lua;
			}
			{	
				plugin =	nvim-ts-autotag;
				config = toLuaFile ./nvim/plugins/autotag.lua;
			}
			{
				plugin = nvim-dap;
				config = toLuaFile ./nvim/plugins/dap.lua;
			}
			{
				plugin = neotest;
				config = toLuaFile ./nvim/plugins/neotest.lua;
			}
			{
				plugin=	noice-nvim;
				config = toLuaFile ./nvim/plugins/noice.lua;
			}
			{
				plugin=	snacks-nvim;
				config = toLuaFile ./nvim/plugins/snacks.lua;
			}
			{
				plugin=	trouble-nvim;
				config = toLuaFile ./nvim/plugins/trouble.lua;
			}
			{
				plugin = actions-preview-nvim;
				config = toLuaFile ./nvim/plugins/actions-preview.lua;
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
				plugin = lualine-nvim;
				config = toLuaFile ./nvim/plugins/lualine.lua;
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
						p.tree-sitter-vimdoc
						p.tree-sitter-yaml
				]));
		  config = toLuaFile ./nvim/plugins/treesitter.lua;
			}
			{
				plugin = harpoon2;
				config = toLua "require(\"harpoon\"):setup()";
			}
			{
				plugin=	nvim-dap-virtual-text;
				config = toLua "require(\"nvim-dap-virtual-text\").setup()";
			}
			{
				plugin = bufferline-nvim;
				config = toLua "require(\"bufferline\").setup()";
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
				plugin = (pkgs.vimUtils.buildVimPlugin {
					name = "github-nvim-theme";
					src = inputs.plugin-github-theme;
				});
				config = "colorscheme github_dark_dimmed";
			}
			{
				plugin = comment-nvim;
				config = toLua "require(\"Comment\").setup()";
			} 
		];
	};
}
