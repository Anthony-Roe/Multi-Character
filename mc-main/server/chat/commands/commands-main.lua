function chatCommandEntered(sender, input)
	local fullCommand = string.gsub(input, "/", "")
	local command = stringsplit(fullCommand, " ")
	local upperCase = stringsplit(string.upper(fullCommand), " ")
	local cmd = upperCase[1]
	local goodArgument = false
	local steamID = GetPlayerIdentifiers(sender)[1]
	local adminlevel = 0
	table.remove(command, 1)
	table.remove(upperCase, 1)

	if Users[steamID].groupID ~= nil then
		adminlevel = tonumber(Users[steamID].groupID)
	end

	if commands[cmd] ~= nil then
		local cmdPerm = tonumber(commands[cmd].perm)
		if adminlevel >= cmdPerm then
			if commands[cmd].args[1] ~= "nil" then
				for i=1, #commands[cmd].args do
					if upperCase[1] == commands[cmd].args[i] then
						goodArgument = true
					elseif upperCase[1] == "HELP" then
						TriggerClientEvent('chatMessage', sender, "HELP", {200, 0, 0}, "" .. commands[cmd].help)
					end
				end
			else
				goodArgument = true
			end
			if goodArgument then
				print("Command: " .. cmd .. " called by " .. GetPlayerName(sender) .. ".")
				local canBeUppercase = true
				for i=1, #lowercaseCmds do
					if cmd == lowercaseCmds[i] then
						canBeUppercase = false
					end
				end
				if canBeUppercase then
					TriggerEvent("FiveLife:Command-" .. cmd, sender, upperCase)
				else
					TriggerEvent("FiveLife:Command-" .. cmd, sender, command)
				end
			else
				TriggerClientEvent('chatMessage', sender, "Invalid Parameters", {200, 0, 0}, "" .. commands[cmd].help)
			end
		else
			print(GetPlayerName(sender) .. " tried to use " .. cmd .. " command.")
		end
	else
		TriggerClientEvent('chatMessage', sender, "", {200, 0, 0}, "Invalid command!")
	end
end

function rconCommandEntered(name, args)
	local cmd = string.upper(name)
	if consoleCommands[cmd] ~= nil then
		TriggerEvent("FiveLife:Console-" .. cmd, args)
		CancelEvent()
	end
end
