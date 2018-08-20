MC = {}
MC.Func = {}
MC.PlayerList = {}

MC.Func.GetLicense = function (src, type)
    -- Types: steam, license, ip
    for k,v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len(type)) == string.lower(type) then
            print(v)
            return v
        end
    end

    return false
end

MC.Func.LoadUser = function(source, data)
    local src = source
    DB.GetUser(src, function(result)
        if (result) then
            MC.PlayerList[src] = CreatePlayer(src, result)
            TriggerClientEvent('mc:setupClientUser', src, MC.PlayerList[src])
        else
            DB.Async.Query('INSERT INTO users (`steam`, `license`, `steamName`, `group`, `playTime`, `char_current`, `char_data`) VALUES (@steam, @license, @steamName, @group, @playTime, @char_current, @char_data);', {steam = MC.Func.GetLicense(src, "steam"), license = MC.Func.GetLicense(src, "license"), steamName = GetPlayerName(src), group = "normal", playTime = 0, char_current = 0, char_data = json.encode({})}, function()
                DB.GetUser(src, function(created)
                    if (created) then
                        MC.PlayerList[src] = CreatePlayer(src, created)
                        TriggerClientEvent('mc:setupClientUser', src, MC.PlayerList[src])
                    end
                end)
            end)
        end
    end)
end

-- [[ Exports ]]--
function GetClientData(source)
    if (MC.PlayerList[source] ~= nil) then
        return MC.PlayerList[source]
    end
    return false
end
