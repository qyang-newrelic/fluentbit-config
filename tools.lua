--[[

 [FILTER]
    Name                lua
    Match               *
    Script              tools.lua
    Call                add_tag

--]]

function add_tag(tag,timestamp,record)
    newData = record
    newData["fb.tag"] = tag 
    return 1, timestamp, newData
end



