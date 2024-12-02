do shell script "
	if [[ -e /Applications/iTerm.app || -e ~/Applications/iTerm.app ]]; then
	        open -a iTerm
	else
        	open -a Terminal
	fi
"
