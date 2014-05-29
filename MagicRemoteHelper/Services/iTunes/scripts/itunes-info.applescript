on escape_quotes(string_to_escape)
    set AppleScript's text item delimiters to the "\""
    set the item_list to every text item of string_to_escape
    set AppleScript's text item delimiters to the "\\\""
    set string_to_escape to the item_list as string
    set AppleScript's text item delimiters to ""
    return string_to_escape
end escape_quotes

on beforeComma(theString, theDelimiter)
    -- save delimiters to restore old settings
    set oldDelimiters to AppleScript's text item delimiters
    -- set delimiters to delimiter to be used
    set AppleScript's text item delimiters to theDelimiter
    -- create the array
    set theArray to every text item of theString
    -- restore the old setting
    set AppleScript's text item delimiters to oldDelimiters
    -- return the result
    return item 1 of theArray as integer
end theSplit

tell application "iTunes"
set ctrack to "{"
set ctrack to ctrack & "\"artist\": \"" & my escape_quotes(current track's artist) & "\""
set ctrack to ctrack & ",\"album\": \"" & my escape_quotes(current track's album) & "\""
set ctrack to ctrack & ",\"duration\": " & my beforeComma(current track's duration as string, ",")
set ctrack to ctrack & ",\"title\": \"" & my escape_quotes(current track's name) & "\""
set ctrack to ctrack & ",\"position\": " & (player position as integer)
set ctrack to ctrack & ",\"state\": \"" & player state & "\""
set ctrack to ctrack & "}"
end tell

