--[[

 [FILTER]
    Name                lua
    Match               *
    Script              time.lua
    Call                check_time

 -- ]]

function check_time(tag,timestamp,record)
    now = os.time()
    ttl = 24 * 60 * 60
    newData = record
    if now - timestamp > ttl then
        newData["logTTL"] = "Remove"
    end 
    return 1, timestamp, newData
end



function append_tag(tag, timestamp, record)
    new_record = record
    new_record["tag"] = tag
    return 1, timestamp, new_record
end

-- Print record to the standard output
function cb_print(tag, timestamp, record)
    output = tag .. ":  [" .. string.format("%f", timestamp) .. ", { "
    for key, val in pairs(record) do
       output = output .. string.format(" %s => %s,", key, val)
    end
    output = string.sub(output,1,-2) .. " }]"
    print(output)
    -- Record not modified so 'code' return value is 0 (first parameter)
    return 0, 0, 0
 end

 function trim(s)
 end
 function cb_nginx(tag, timestamp, record)
    new_record = record
    new_record["nr_tag"] = tag
    log_source = record["stream"] 
    -- if log_source then print("stream ->" .. log_source) end
    if log_source and log_source:find("stdout") then 
     log_line = record["nginx_log"]
     if log_line then log_line = log_line:gsub("^[%s{]*(.-)[}%s]*$","%1") end
     if log_line then
        -- print (log_line)
        ram = {}
        local pattern = string.format("([^%s]+)", ",")
        local pattern_b =  "([^:]+):(.*)"
        log_line:gsub(pattern, function(c)
            --print("c:" .. c)
            local key,value = c:match(pattern_b)
            if key then
              key = key:match("^%s*(.-)%s*$")
              -- if value then  value = value:gsub("\"*([^\"]-)\"*$","%1") end
              if value then  value = value:gsub("^[\"%s]*(.-)[\"%s]*$","%1") end
              if not value then  value = "-" end
              ram[key] =  value
            end
        end)
        -- remove the old value
        new_record["nginx_log"] = nil
        new_record["nginx"] = ram
     end
    end
    return 1, timestamp, new_record
 end

 -- Drop the record
 function cb_drop(tag, timestamp, record)
    return -1, 0, 0
 end
 
 -- Compose a new JSON map and report it
 function cb_replace(tag, timestamp, record)
    -- Record modified, so 'code' return value (first parameter) is 1
    new_record = {}
    new_record["new"] = 12345
    new_record["old"] = record
    return 1, timestamp, new_record
 end