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
			FixCursorHold-nvim
			SchemaStore-nvim
			advanced-git-search-nvim
			cmp-buffer
			cmp-nvim-lsp
			cmp-nvim-lsp-signature-help
			cmp-path
			cmp_luasnip
			colorizer
			editorconfig-nvim
			friendly-snippets
			lspkind-nvim
			lualine-nvim
			luasnip
			markdown-preview-nvim
			mini-icons
			neotest-dotnet
			noice-nvim
			nui-nvim
			nvim-nio
			nvim-web-devicons
			nvim-notify
			plenary-nvim
			popup-nvim
			telescope-fzf-native-nvim
			telescope-live-grep-args-nvim
			telescope-media-files-nvim
			telescope-ui-select-nvim
			undotree
			vim-dadbod
			vim-dadbod-completion
			vim-dadbod-ui
			vim-dotenv
			vim-fugitive
			vim-matchup
			vim-tmux-navigator
			which-key-nvim

		  # From source
			{
				plugin = (pkgs.vimUtils.buildVimPlugin {
					name = "nx-nvim";
					src = inputs.plugin-nx;
          nvimSkipModules = [
						"nx.actions"
						"nx.multirunners"
						"nx.generators"
						"nx.read-configs"
						"nx.form-renderers"
						"nx"
          ];
				});
				config = toLuaFile ./nvim/plugins/nx.lua;
			}
			(pkgs.vimUtils.buildVimPlugin {
				name = "vim-freemarker";
				src = inputs.plugin-vim-freemarker;
			})
			{ 
				plugin = (pkgs.vimUtils.buildVimPlugin {
					name = "gp";
					src = inputs.plugin-gp;
				});
				config = toLuaFile ./nvim/plugins/gp.lua;
			}

			# With config
			{ 
				plugin = roslyn-nvim;
			 	config = toLuaFile ./nvim/plugins/roslyn.lua;
			}
			# { 
			# 	plugin = rzls-nvim;
			# 	config = toLua "require(\"rzls\").setup{}";
			# }
			{ 
				plugin = nvim-dap-ui;
				config = toLuaFile ./nvim/plugins/dapui.lua;
			}
			{ 
				plugin = conform-nvim;
				config = toLuaFile ./nvim/plugins/conform.lua;
			}
			{
				plugin = tailwind-tools-nvim;
				config = toLuaFile ./nvim/plugins/tailwind-tools.lua;
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
				plugin = snacks-nvim;
				config = toLuaFile ./nvim/plugins/snacks.lua;
			}
			{
				plugin = yanky-nvim;
				config = toLua "require(\"yanky\").setup()";
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
				plugin = mason-nvim;
				config = toLuaFile ./nvim/plugins/mason.lua;
			}
			{
				plugin = mason-tool-installer-nvim;
				config = toLuaFile ./nvim/plugins/mason-installer.lua;
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
				plugin = (nvim-treesitter.withAllGrammars);
				config = toLuaFile ./nvim/plugins/treesitter.lua;
			}
			{
				plugin = harpoon2;
				config = toLua "require(\"harpoon\"):setup()";
			}
			{
				plugin = diffview-nvim;
				config = toLua "require(\"diffview\").setup()";
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
				plugin = claude-code-nvim;
				config = toLuaFile ./nvim/plugins/claude-code.lua;
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
				plugin = github-nvim-theme;
				config = "colorscheme github_dark_dimmed";
			}
			{
				plugin = comment-nvim;
				config = toLua "require(\"Comment\").setup()";
			} 
			{
				plugin = nvim-lspconfig;
				config = toLuaFile ./nvim/plugins/lsp.lua;
			}
		];
	};
}
