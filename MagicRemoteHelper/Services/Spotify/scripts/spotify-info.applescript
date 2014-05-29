on escape_quotes(string_to_escape)
  set AppleScript's text item delimiters to the "\""
  set the item_list to every text item of string_to_escape
  set AppleScript's text item delimiters to the "\\\""
  set string_to_escape to the item_list as string
  set AppleScript's text item delimiters to ""
  return string_to_escape
end escape_quotes

tell application "Spotify"
  set ctrack to "{"
  set ctrack to ctrack & "\"artist\": \"" & my escape_quotes(current track's artist) & "\""
  set ctrack to ctrack & ",\"album\": \"" & my escape_quotes(current track's album) & "\""
  set ctrack to ctrack & ",\"duration\": " & current track's duration
  set ctrack to ctrack & ",\"title\": \"" & my escape_quotes(current track's name) & "\""
  set ctrack to ctrack & ",\"position\": " & (player position as integer)
  set ctrack to ctrack & ",\"state\": \"" & player state & "\""
  set ctrack to ctrack & "}"
end tell
