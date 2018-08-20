MC = {}
MC.Commands = {}
MC.Vars = {Instanced = false}
MC.Func = {FM = {}}
MC.Exports = {}
MC.Game = {}
MC.Cams = {}
MC.Menu = {}
MC.Coords = 
    {
    Spawn = 
        {
		charSelect = {x = 189.114, y = -838.8276, z = 121.5237, h = 183.572}, 
		charCreation = {x = 402.83, y = -996.8819, z = -99.00025, h = 180.086},
        firstSpawn = {{x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        }
    }

MC.Func.charSelect = function()
	MC.Cams.charSelect = CreateCam("DEFAULT_SCRIPTED_CAMERA")
	SetCamCoord(MC.Cams.charSelect , MC.Coords.Spawn.charSelect.x, MC.Coords.Spawn.charSelect.y, MC.Coords.Spawn.charSelect.z + 1.0)
	PointCamAtCoord(MC.Cams.charSelect , 217.3177, -911.95, 30.69)
	SetCamActive(MC.Cams.charSelect, true)
	RenderScriptCams( 1, 0, 0, 0, 0)

	MC.Func.FM.updateModel("mp_m_freemode_01", function()

		local playerPed = GetPlayerPed(-1)
		SetEntityVisible(playerPed, false)
		RequestCollisionAtCoord(MC.Coords.Spawn.charSelect.x, MC.Coords.Spawn.charSelect.y, MC.Coords.Spawn.charSelect.z)
		SetEntityCoords(playerPed, MC.Coords.Spawn.charSelect.x, MC.Coords.Spawn.charSelect.y, MC.Coords.Spawn.charSelect.z-1)
		FreezeEntityPosition(playerPed, true)
		SetPlayerInvincible(PlayerId(), true)
		SetEntityHeading(playerPed, MC.Coords.Spawn.charSelect.h)
		TriggerEvent("mc:openMenu", "charSelect")

	end)
end

MC.Func.charCreation = function()
	local playerPed = GetPlayerPed(-1)
	RequestCollisionAtCoord(MC.Coords.Spawn.charCreation.x, MC.Coords.Spawn.charCreation.y, MC.Coords.Spawn.charCreation.z-1)
	SetEntityCoords(playerPed, MC.Coords.Spawn.charCreation.x, MC.Coords.Spawn.charCreation.y, MC.Coords.Spawn.charCreation.z-1)
	SetEntityHeading(playerPed, MC.Coords.Spawn.charCreation.h)

	MC.Vars.Instanced = true

	local hx, hy, hz = table.unpack(GetPedBoneCoords(playerPed, 31086)) -- Head Bone Coords
	local offCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.6, 0.0)
	MC.Cams.charCreation = CreateCam("DEFAULT_SCRIPTED_CAMERA")
	SetCamCoord(MC.Cams.charCreation , offCoords.x, offCoords.y, hz)
	PointCamAtCoord(MC.Cams.charCreation , table.unpack(GetPedBoneCoords(playerPed, 31086)))
	SetCamActive(MC.Cams.charCreation, true)
	RenderScriptCams( 1, 0, 0, 0, 0)

	TriggerEvent("mc:openMenu", "charCreation")

end

MC.Func.FM.updateFace = function(skin)
	Citizen.CreateThread(function()
		Citizen.Wait(500)
		local playerPed = GetPlayerPed(-1)
		SetPedHeadBlendData(playerPed, skin.face.mom, skin.face.dad, 0, skin.face.mom, skin.face.dad, 0, skin.resemblance, skin.skinmix, 0, false)
		SetPedComponentVariation(playerPed, 2, skin.hair.style, 0, 0)
		SetPedHairColor(playerPed, skin.hair.color[1], skin.hair.color[2])

		SetPedHeadOverlay(playerPed, 1, skin.facialHair.beard.style, skin.facialHair.beard.opacity)
		SetPedHeadOverlayColor(playerPed, 1, 1, skin.facialHair.beard.color[1], skin.facialHair.beard.color[2])

		SetPedHeadOverlay(playerPed, 2, skin.facialHair.eyebrow.style, skin.facialHair.eyebrow.opacity)
		SetPedHeadOverlayColor(playerPed, 2, 1, skin.facialHair.eyebrow.color[1], skin.facialHair.eyebrow.color[2])

		SetPedHeadOverlay(playerPed, 3, skin.ageing.style, skin.ageing.opacity)

		SetPedHeadOverlay(playerPed, 8, skin.lipstick.style, skin.lipstick.opacity)
		SetPedHeadOverlayColor(playerPed, 8, 1, skin.lipstick.color[1], skin.lipstick.color[2])	

		SetPedHeadOverlay(playerPed, 4, skin.makeup.style, skin.makeup.opacity)

		SetPedEyeColor(playerPed, skin.eye.style)

		SetPedHeadOverlay(playerPed, 0, skin.blemishes.style, skin.blemishes.opacity)

		SetPedHeadOverlay(playerPed, 6, skin.complexion.style, skin.complexion.opacity)
		return
	end)
end

MC.Func.FM.updateModel = function(hash, cb)
	Citizen.CreateThread(function()
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			Citizen.Wait(500)
		end
		SetPlayerModel(PlayerId(), hash)
		SetPedDefaultComponentVariation(PlayerPedId())
		SetEntityAsMissionEntity(PlayerPedId(), true, true)
		SetModelAsNoLongerNeeded(PlayerPedId())
		if cb then cb() end
		return
	end)
end

MC.Func.Input = function(TextEntry, ExampleText, MaxStringLength)
	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLength	-->	Maximum String Length

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return 'Invalid' --Returns false if the typing got aborted
	end
end

MC.Func.DrawText3d = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 75, 75, 75, 68)
end

MC.Func.StartLocationSave = function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10000)
			local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
			local h = GetEntityHeading(PlayerPedId())
			TriggerServerEvent('mc:updateCurChar', "charLocation", {x = x, y = y, z = z, h = h})
		end
	end)
end

MC.Func.SetupCommands = function()
    Citizen.CreateThread(function()
        for k,v in pairs(MC.Commands) do
            if v.exec then
                if v.permLevel <= MC.Data.permLevel then
                    RegisterCommand(tostring(k), function(source, args)
                        v.exec(source, args)
					end, false)
                    TriggerEvent('chat:addSuggestion', '/' .. tostring(k), v.helpText, v.helpParams)
                else
                    print("You do not have permission for command: " .. k)
                end
            end
        end
    end)
end

MC.Game.SpawnObject = function(model, coords, cb)

	local model = (type(model) == "number" and model or GetHashKey(model))

	Citizen.CreateThread(function()
	
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(500)
		end

		local object = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)
		PlaceObjectOnGroundProperly(object)
		SetEntityAsMissionEntity(object, false, true)

		if cb then cb() end
	end)
  
end


--[[ Threads ]]--

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if MC.Vars.Instanced then
			for i=0, MC.MaxPlayers do
				local otherPlayerPed = GetPlayerPed(i)
				
				if otherPlayerPed ~= PlayerPedId() then
					SetEntityLocallyInvisible(otherPlayerPed)
					SetEntityNoCollisionEntity(PlayerPedId(),  otherPlayerPed,  true)
				end
			end
		end
	end
end)

--[[ Exports ]]--

function GetClientData()
	return MC.Data
end

function GetCharInventory()
	return MC.Data.getCharInventory(MC.Data.char_current)
end