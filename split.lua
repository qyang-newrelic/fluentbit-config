--[[

 [FILTER]
    Name                lua
    Match               *
    Script              time.lua
    Call                check_time

--]]

function split_payload(tag,timestamp,record)
    data = record["message"]
    chunkSize = 4096
    newRecord = record 
    if data then 
        newRecord["payload"]  = data:sub(1,chunkSize - 1)
        index=1
        for i=chunkSize, #data, chunkSize do
            key = "payload_" .. index
            newRecord[key] = data:sub(i,i+chunkSize - 1)
            index= index + 1
        end
    end
    return  1, timestamp, newRecord
end
