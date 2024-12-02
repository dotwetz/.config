set titleString to ""

tell application "Chromium"
	
	set window_list to every window
	repeat with the_window in window_list
		set tab_list to every tab in the_window
		repeat with the_tab in tab_list
			set the_title to the URL of the_tab
			set titleString to titleString & the_title & return
		end repeat
	end repeat
	
end tell