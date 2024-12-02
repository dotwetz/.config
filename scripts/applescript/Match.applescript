(*
Match - Use sips to match an image to another color space.
The source profile for the match is the image's embedded profile if it has one or the default color profile for its color model.
The destination profile for the match is chosen by the user.

Copyright © 2009Ð2020 Apple Inc.

You may incorporate this Apple sample code into your program(s) without
restriction.  This Apple sample code has been provided "AS IS" and the
responsibility for its operation is yours.  You are not permitted to
redistribute this Apple sample code as "Apple sample code" after having
made changes.  If you're going to redistribute the code, we require
that you make it clear that the code was descended from Apple sample
code, but that you've made changes.

*)

on run
	display dialog "Match an image to another color space."
	set chosenFile to choose file with prompt "Choose an image " default location path to desktop folder
	open chosenFile
end run


on open draggedItems
	set matchProf to choose file with prompt "Choose destination space profile" default location POSIX file "/System/Library/ColorSync/Profiles"
	repeat with thisFile in (draggedItems as list)
		try
			set profPath to quoted form of POSIX path of matchProf
			set filePath to quoted form of POSIX path of thisFile
			set cmdLine to ("sips --matchTo " & profPath & " " & filePath) as string
			do shell script cmdLine
		end try
	end repeat
end open
