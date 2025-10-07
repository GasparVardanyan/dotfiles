local mp = require "mp"

local state = {
	path = nil,
	time = 0,
	counter = 0,
}

local function save_state_on_file_end()
	print ("save_state_on_file_end entered")
	local path = mp.get_property("path")
	if path then
		print ("save_state_on_file_end have path: " .. path)
		state.path = path
		state.time = mp.get_property_number("time-pos", 0)
		print("SmartResume: State saved for '" .. state.path:gsub(".*/", "") .. "'")
	end
end
mp.register_event("end-file", save_state_on_file_end)





local function on_playlist_change(_, new_playlist)
	local first_entry = mp.get_property('playlist/0/filename')
	if first_entry:match('%.m3u$')
	then
		state.counter = state.counter + 1

		if 2 == state.counter
		then
			state.counter = 0
			print ("PLAYLIST: " .. first_entry)
			if nil ~= state.path
			then
				print ("LT: " .. state.path)
			else
				print ("NO FILE")
			end
		end
	end
end

mp.observe_property("playlist", "native", on_playlist_change)
