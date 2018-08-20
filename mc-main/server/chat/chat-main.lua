AddEventHandler('chatMessage', function(source, color, message)
	local steamID = GetPlayerIdentifiers(source)[1]
	if (Users[steamID].groupID ~= nil) then
		if(string.sub(message, 1, 1) == "/" and string.len(message) >= 2) then
			chatCommandEntered(source, message)
			CancelEvent()
		elseif string.len(message) >= 1 then
			local tag = ""
			local color = {255, 255, 255}
			local adminlevel = tonumber(Users[steamID].groupID)
			if(adminlevel == 0)then
				tag = "USER"
				color = {255, 255, 255}
			elseif(adminlevel == 1)then
				tag = "MOD"
				color = {25, 7, 155}
			elseif(adminlevel == 2)then
				tag = "ADMIN"
				color = {106, 9, 186}
			elseif(adminlevel == 3)then
				tag = "SR-ADMIN"
				color = {224, 204, 24}
			elseif(adminlevel == 4)then
				tag = "HEAD-ADMIN"
				color = {3, 124, 15}
			elseif(adminlevel == 5)then
				tag = "MANAGER"
				color = {226, 177, 27}
			elseif(adminlevel == 6)then
				tag = "LEAD"
				color = {200, 0, 0}
			elseif(adminlevel > 6)then
				tag = "DEV"
				color = {200, 0, 0}
			end

			TriggerClientEvent('chatMessage', -1, "[" .. tag .. "] " .. Users[steamID].rp_name, color, message)
			CancelEvent()
		else
			CancelEvent()
		end
	else
		if string.sub(message, 1, 3) == "/rp" then
			chatCommandEntered(source, message)
		else
			TriggerClientEvent('chatMessage', source, "HELP: ", {200, 0, 0}, "Use ^3/rp First LastName")
		end
		CancelEvent()
	end
end)
