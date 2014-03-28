set curVolume to output volume of (get volume settings)

if curVolume < 94 then
    set newVolume to curVolume + 6
else
    set newVolume to 100
end if
set volume output volume newVolume