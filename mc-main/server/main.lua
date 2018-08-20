Citizen.CreateThread(function()
    local function playerConnect(name, setKickReason, deferrals)
        local src = source
        deferrals.defer()
        Citizen.Wait(1000)

        if not GetPlayerIdentifiers(src) then
            deferrals.done("Error: Couldn't find any of your identifiers!")
            CancelEvent()
            return
        else
            if MC.Func.GetLicense(src, "steam") then -- Checks for steam
                if MC.Func.GetLicense(src, "license") then
                    -- TO DO: Check for bans
                    deferrals.done()
                else
                    deferrals.done("Error: Couldn't find FiveM license. Rejecting connection.")
                    CancelEvent()
                    return
                end
            else
                deferrals.done("Error: Couldn't find Steam ID. Rejecting connection.")
                CancelEvent()
                return
            end
        end
    end

    local function playerDropped(name, reason)
        local src = source
        if MC.PlayerList[src] then
            if MC.PlayerList[src].status.spawned then
                DB.UpdateUser(MC.PlayerList[src], function()
                    MC.PlayerList[src] = nil
                end)
            end
        end
    end

    AddEventHandler("playerConnecting", playerConnect)
    AddEventHandler("playerDropped", playerDropped)
end)