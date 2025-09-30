local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed
		}
	end
end

require 'lualine'.setup {
	sections = {
		lualine_b = {
			{ 'diff', source = diff_source },
			{ 'b:gitsigns_head', icon = '' },
		},
		lualine_c = {
			{
				'filename',
				path = 1, -- 1 = relative path, 2 = absolute path
			}
		},
		lualine_x = {
			'encoding', -- shows file encoding (utf-8, etc)
			{
				function()
					return vim.bo.bomb and '[BOM]' or ''
				end,
			},
			{
				'fileformat',
				icons_enabled = true,
				symbols = {
					unix = 'LF',
					dos = 'CRLF',
					mac = 'CR',
				},
			},
		},
	}
}
