RegisterNetEvent('mc:setupClientUser')
AddEventHandler('mc:setupClientUser', function(data)
    MC.Data = data
    MC.Data.permLevel = 2
    MC.Cams.normal = GetRenderingCam()
    MC.Func.charSelect()
    TriggerEvent('chat:refreshCommands')
    MC.Func.SetupCommands()
end)

RegisterNetEvent('mc:sendUserInfo')
AddEventHandler('mc:sendUserInfo', function(data)
    if data.char_data then MC.Data.char_data = data.char_data end
    if data.char_current then MC.Data.char_current = data.char_current end
    if data.group then MC.Data.group = data.group end
end)

RegisterNetEvent('mc:finishChar')
AddEventHandler('mc:finishChar', function(data)
    MC.Data = data
    MC.Vars.Instanced = false
    math.randomseed(GetGameTimer())
    local i = math.random(1, #MC.Coords.Spawn.firstSpawn)
    SetEntityCoords(PlayerPedId(), MC.Coords.Spawn.firstSpawn[i].x, MC.Coords.Spawn.firstSpawn[i].y, MC.Coords.Spawn.firstSpawn[i].z)
    SetEntityHeading(PlayerPedId(), MC.Coords.Spawn.firstSpawn[i].h)
    SetEntityVisible(PlayerPedId(), true)
    SetPlayerInvincible(PlayerId(), false)

    MC.Func.charSelect()
end)