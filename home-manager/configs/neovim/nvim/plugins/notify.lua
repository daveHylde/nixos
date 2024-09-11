require("notify").setup {
	stages = 'fade_in_slide_out',
	background_colour = 'FloatShadow',
	timeout = 3000,
}
local banned_messages = { "No information available", "Completion started", "An Error Occurred ..." }
vim.notify = function(msg, ...)
  for _, banned in ipairs(banned_messages) do
    if msg == banned then
      return
    end
  end
  return require("notify")(msg, ...)
end
