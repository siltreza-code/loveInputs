unpack = unpack or table.unpack
local rand = {}

function rand:choice(list, count)
    count = count or 1
    local selected = {}
    for i = 1, count do
        table.insert(selected, list[math.random(1, #list)])
    end

    if count == 1 then return selected[1] end
    return selected
end

function rand:genUUID4()
    local temp = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    local new = string.gsub(temp, "x", function()
        return self:choice({"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"})
    end)
    new = string.gsub(new, "y", function() return self:choice({"8","9","a","b"}) end)
    return new
end

return rand
