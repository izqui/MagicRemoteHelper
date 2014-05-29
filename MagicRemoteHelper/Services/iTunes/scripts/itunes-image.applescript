tell application "iTunes" to tell artwork 1 of current track
    set d to raw data
    if format is «class PNG » then
        set x to "png"
    else
        set x to "jpg"
    end if
end tell

set savePath to (path to temporary items from user domain as string) & "it." & x

(savePath)
set b to open for access file result with write permission
set eof b to 0
write d to b
close access b

return  POSIX path of savePath