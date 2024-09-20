tell application "System Events"
    tell appearance preferences
        set dark mode to not dark mode
    end tell
end tell

tell application "System Preferences"
    activate
    set current pane to pane "com.apple.preference.keyboard"
end tell

tell application "System Events"
    tell process "System Preferences"
        delay 1
        click radio button "Keyboard" of tab group 1 of window 1
        
        -- Set Key Repeat to fastest
        set value of slider 1 of group 1 of tab group 1 of window 1 to 100
        
        -- Set Delay Until Repeat to shortest
        set value of slider 2 of group 1 of tab group 1 of window 1 to 100
    end tell
end tell

tell application "System Preferences" to quit