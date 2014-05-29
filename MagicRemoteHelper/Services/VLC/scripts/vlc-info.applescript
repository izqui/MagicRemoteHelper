tell application "VLC"

set info to "{"
set info to info &  "\"title\": \"" & name of current item & "\", "
set info to info & "\"duration\": " & duration of current item & ","
set info to info & "\"position\": " & current time & ","
set info to info &  "\"state\": " & playing of application "VLC"
set info to info & "}"
end tell