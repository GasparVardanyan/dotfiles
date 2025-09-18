-- persistent-vid.lua
-- Start mpv with a predefined video track (from CLI/script-opts)
-- and let you toggle persistently with a key.

local mp = require "mp"
local opts = { default_vid = 1 }
require("mp.options").read_options(opts, "persistent-vid")

-- If mpv was started with --vid=N, respect that over default_vid
local cli_vid = mp.get_property_number("vid")
local selected_vid = cli_vid or opts.default_vid

mp.register_event("file-loaded", function()
	if mp.get_property_number("vid") ~= selected_vid then
		mp.set_property_number("vid", selected_vid)
	end
end)

mp.add_key_binding("V", "toggle-persistent-vid", function()
	local vid = mp.get_property_number("vid")
	if vid == 1 then
		selected_vid = 2
	else
		selected_vid = 1
	end
	mp.set_property_number("vid", selected_vid)
	mp.osd_message("Now using video track " .. selected_vid .. " (persistent)")
end)
