--[[

 [FILTER]
    Name                lua
    Match               *
    Script              time.lua
    Call                check_time

--]]

function check_time(tag,timestamp,record)
    now = os.time()
    ttl = 0.1 * 60 * 60
    newData = record
    newData["logTTL"] = ttl 
    newData["logProcTime"] = now 
    newData["logGenTime"] = timestamp 
    newData["logLagTime"] = now - timestamp 
    if now - timestamp > ttl then
        newData["logTTLStatus"] = "Remove"
        -- drop the record
        return 1, 0, 0
        -- return 1, timestamp, newData
    else
        newData["logTTLStatus"] = "Keep"
        return 1, timestamp, newData
    end 
end



