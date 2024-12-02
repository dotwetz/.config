tell application "System Events"
    -- Get the frontmost application
    set frontApp to first application process whose frontmost is true
    set appName to name of frontApp
end tell

-- Get screen size of the current display
tell application "Finder"
    set screenBounds to bounds of window of desktop -- Main screen resolution
end tell

-- Calculate display size
set {screenX1, screenY1, screenX2, screenY2} to screenBounds
set displayWidth to screenX2 - screenX1
set displayHeight to screenY2 - screenY1

-- Get dock size if visible
if (do shell script "defaults read com.apple.dock autohide") is equal to "0" then
    set dockSize to ((do shell script "defaults read com.apple.dock tilesize") as number) + 19
else
    set dockSize to 0
end if

-- Menubar size (standard is 22px)
set menubarSize to 22

-- Set window to the upper-left quadrant
tell application appName
    tell window 1
        set bounds to {screenX1, menubarSize, displayWidth / 2, displayHeight / 2}
    end tell
end tell