set curVolume to output volume of (get volume settings)

if curVolume > 6 then
    set newVolume to curVolume - 6
else
    set newVolume to 0
end if

set volume output volume newVolume