tell application "Finder"
	activate
	-- wait for Finder to be ready
	delay 1
	-- press keys command-shift-g
	keystroke "p" using {command down, option down, control down}
end tell