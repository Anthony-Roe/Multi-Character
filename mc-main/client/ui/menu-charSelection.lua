MC.Menu["charSelect"] = NativeUI.CreateMenu("Character Select", "Multi-Character", 744.5, 460)
MC.Menu["charSelect"].Controls.Back.Enabled = false
MC.Menu["charSelect"].Settings.MouseEdgeEnabled = false
_menuPool:Add(MC.Menu["charSelect"])

MC.Menu["charSelect"].GenerateMenu = function()
    Citizen.CreateThread(function()
        MC.Menu["charSelect"]:Clear()
        if #MC.Data.char_data > 0 then
            for i=1, #MC.Data.char_data, 1 do
                if MC.Data.char_current == MC.Data.char_data[i].id then
                    local chars = NativeUI.CreateItem("Last: " .. MC.Data.char_data[i].name.firstname .. " " .. MC.Data.char_data[i].name.lastname, "")
                    MC.Menu["charSelect"]:AddItem(chars)
                    chars.Activated = function(ParentMenu, SelectedItem)
                        _menuPool:CloseAllMenus()
                        TriggerServerEvent('mc:updateCurChar', "char_current", MC.Data.char_data[i].id)
                        SetCamCoord(MC.Cams.charSelect,GetGameplayCamCoords())
                        SetCamRot(MC.Cams.charSelect, GetGameplayCamRot(2), 2)
                        RenderScriptCams( 1, 1, 0, 0, 0)
                        RenderScriptCams( 0, 1, 1000, 0, 0)
                        SetCamActive(MC.Cams.normal, true)
                        EnableGameplayCam(true)
                        SetCamActive(MC.Cams.charSelect, false)
                        SetEntityVisible(PlayerPedId(), true)
                        SetPlayerInvincible(PlayerId(), false)
                        if MC.Data.char_data[i].location then
                            SetEntityCoords(PlayerPedId(), MC.Data.char_data[i].location.x, MC.Data.char_data[i].location.y, MC.Data.char_data[i].location.z)
                            SetEntityHeading(PlayerPedId(), MC.Data.char_data[i].location.h)
                        else
                            local l = math.random(1, #MC.Coords.Spawn.firstSpawn)
                            SetEntityCoords(PlayerPedId(), MC.Coords.Spawn.firstSpawn[l].x, MC.Coords.Spawn.firstSpawn[l].y, MC.Coords.Spawn.firstSpawn[l].z)
                            SetEntityHeading(PlayerPedId(), MC.Coords.Spawn.firstSpawn[l].h)
                        end
                        FreezeEntityPosition(PlayerPedId(), false)
                        MC.Func.FM.updateModel(MC.Data.char_data[i].skin.model, function()
                            MC.Func.FM.updateFace(MC.Data.char_data[i].skin)
                            TriggerServerEvent('mc:updateCurChar', "status", {statusType = "spawned", status = true})
                            MC.Func.StartLocationSave()
                        end)
                        return
                    end
                else
                    local chars = NativeUI.CreateItem(MC.Data.char_data[i].name.firstname .. " " .. MC.Data.char_data[i].name.lastname, "")
                    MC.Menu["charSelect"]:AddItem(chars)
                    chars.Activated = function(ParentMenu, SelectedItem)
                        _menuPool:CloseAllMenus()
                        TriggerServerEvent('mc:updateCurChar', "char_current", MC.Data.char_data[i].id)
                        SetCamCoord(MC.Cams.charSelect,GetGameplayCamCoords())
                        SetCamRot(MC.Cams.charSelect, GetGameplayCamRot(2), 2)
                        RenderScriptCams( 1, 1, 0, 0, 0)
                        RenderScriptCams( 0, 1, 1000, 0, 0)
                        SetCamActive(MC.Cams.normal, true)
                        EnableGameplayCam(true)
                        SetCamActive(MC.Cams.charSelect, false)
                        SetEntityVisible(PlayerPedId(), true)
                        SetPlayerInvincible(PlayerId(), false)
                        if MC.Data.char_data[i].location then
                            SetEntityCoords(PlayerPedId(), MC.Data.char_data[i].location.x, MC.Data.char_data[i].location.y, MC.Data.char_data[i].location.z)
                            SetEntityHeading(PlayerPedId(), MC.Data.char_data[i].location.h)
                        else
                            local l = math.random(1, #MC.Coords.Spawn.firstSpawn)
                            SetEntityCoords(PlayerPedId(), MC.Coords.Spawn.firstSpawn[l].x, MC.Coords.Spawn.firstSpawn[l].y, MC.Coords.Spawn.firstSpawn[l].z)
                            SetEntityHeading(PlayerPedId(), MC.Coords.Spawn.firstSpawn[l].h)
                        end
                        FreezeEntityPosition(PlayerPedId(), false)
                        MC.Func.FM.updateModel(MC.Data.char_data[i].skin.model, function()
                            MC.Func.FM.updateFace(MC.Data.char_data[i].skin)
                            TriggerServerEvent('mc:updateCurChar', "status", {statusType = "spawned", status = true})
                            MC.Func.StartLocationSave()
                        end)
                        return
                    end
                end
            end
        end
        if #MC.Data.char_data >= 0 and #MC.Data.char_data < 3 then
            local newChar = NativeUI.CreateItem("Create Character", "Create a new character now!")
            MC.Menu["charSelect"]:AddItem(newChar)
            newChar.Activated = function(ParentMenu, SelectedItem)
                SetCamActive(MC.Cams.charSelect, false)
                EnableGameplayCam(true)
                SetCamCoord(MC.Cams.charSelect,GetGameplayCamCoords())
                SetCamRot(MC.Cams.charSelect, GetGameplayCamRot(2), 2)
                RenderScriptCams( 1, 1, 0, 0, 0)
                RenderScriptCams( 0, 1, 0, 0, 0)
                SetCamActive(MC.Cams.normal, true)
                EnableGameplayCam(true)
                SetCamActive(MC.Cams.charSelect, false)
                SetEntityVisible(PlayerPedId(), true)
                MC.Func.charCreation()
            end
            return
        end
    end)
end