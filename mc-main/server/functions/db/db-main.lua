DB.GetUser = function(source, cb)
    DB.Async.QueryResult("SELECT * FROM `users` WHERE `steam` = @steam", {["@steam"] = MC.Func.GetLicense(source, "steam")}, function(result)
        if #result > 0 then
            cb(result[1])
        else
            cb(false)
        end
    end)
end

DB.UpdateUser = function(player, cb)
    local playTime = (os.time() - player.connectTime) + player.playTime
    DB.Async.Query("UPDATE `users` SET `steamName` = @steamName, `group` = @group, `group_level` = @group_level, `playTime` = @playTime, `char_current` = @char_current, `char_data` = @char_data WHERE `steam` = @steam;", {
        ['@steam'] = player.identifiers.steam, 
        ['@steamName'] = GetPlayerName(player.source),
        ['@group'] = tostring(player.group), 
        ['@group_level'] = tostring(player.group_level),
        ['@playTime'] = playTime, 
        ['@char_current'] = player.char_current,
        ['@char_data'] = json.encode(player.char_data),
    }, 
    function()
        if cb then cb() end
    end)
end