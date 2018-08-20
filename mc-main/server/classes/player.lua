function CreatePlayer(source, data)
    local self = {}
    
    self.source = source
    self.identifiers = { steam = MC.Func.GetLicense(self.source, "steam"), license = MC.Func.GetLicense(self.source, "license")}
    self.connectTime = os.time()
    self.group = data.group and data.group or "normal"
    self.group_level = data.group_level and data.group_level or 0
    self.char_data = data.char_data and json.decode(data.char_data) or {}
    self.char_current = data.char_current and data.char_current or 0
    self.playTime = data.playTime and data.playTime or 0
    self.status = {connected = true, spawned = false}

    self.getCurrentChar = function()
        if (not self.status.spawned) then return end
        for i=1, #self.char_data, 1 do
            if (self.char_data[i].id == self.char_current) then
                return self.char_data[i], i
            end
        end
        return false
    end

    self.getCharInventory = function(charId)
        if (charId) then
            for i=1, #self.char_data, 1 do
                if (self.char_data[i].id == charId) then
                    if (self.char_data[i].inventory) then
                        return self.char_data[i].inventory
                    else
                        return false
                    end
                end
            end
            return false
        end
        return false
    end

    self.addMoney = function(amount)
        if (amount > 0) then
            self.getCurrentChar().finance.cash = (self.getCurrentChar().finance.cash + amount)
            TriggerClientEvent('pNotify:SetQueueMax', self.source, "global", 5)
            TriggerClientEvent('pNotify:SendNotification', self.source, {
                text = ("<b style='color:green'>$" .. tonumber(amount) .. " </b> received!"),
                type = "success",
                layout = "topRight",
                theme = "gta",
                timeout = 2000,
                animation = {
                    open = "noty_effects_open",
                    close = "noty_effects_close",
                },
            })
        end
        TriggerClientEvent('mc:sendUserInfo', self.source, {char_data = self.char_data})
    end

    self.removeMoney = function(amount)
        self.getCurrentChar().finance.cash = (self.getCurrentChar().finance.cash - amount) >= 0 and (self.getCurrentChar().finance.cash - amount) or 0
        TriggerClientEvent('pNotify:SetQueueMax', self.source, "global", 5)
        TriggerClientEvent('pNotify:SendNotification', self.source, {
            text = ("<b style='color:red'>$" .. tonumber(amount) .. " </b> removed!"),
            type = "error",
            layout = "topRight",
            theme = "gta",
            timeout = 2000,
            animation = {
                open = "noty_effects_open",
                close = "noty_effects_close",
            },
        })
        TriggerClientEvent('mc:sendUserInfo', self.source, {char_data = self.char_data})
    end

    self.addBank = function(amount)
        if (amount > 0) then
            self.getCurrentChar().finance.bank = (self.getCurrentChar().finance.bank + amount)
            TriggerClientEvent('pNotify:SetQueueMax', self.source, "global", 5)
            TriggerClientEvent('pNotify:SendNotification', self.source, {
                text = ("<b style='color:green'>$" .. tonumber(amount) .. " </b> added to the bank!"),
                type = "success",
                layout = "topRight",
                theme = "gta",
                timeout = 2000,
                animation = {
                    open = "noty_effects_open",
                    close = "noty_effects_close",
                },
            })
        end
        TriggerClientEvent('mc:sendUserInfo', self.source, {char_data = self.char_data})
    end

    self.removeBank = function(amount)
        self.getCurrentChar().finance.bank = (self.getCurrentChar().finance.bank - amount) >= 0 and (self.getCurrentChar().finance.bank - amount) or 0
        TriggerClientEvent('pNotify:SetQueueMax', self.source, "global", 5)
        TriggerClientEvent('pNotify:SendNotification', self.source, {
            text = ("<b style='color:red'>$" .. tonumber(amount) .. " </b> removed from your bank!"),
            type = "error",
            layout = "topRight",
            theme = "gta",
            timeout = 2000,
            animation = {
                open = "noty_effects_open",
                close = "noty_effects_close",
            },
        })
        TriggerClientEvent('mc:sendUserInfo', self.source, {char_data = self.char_data})
    end

    self.addDirtCash = function(amount)
        if (amount > 0) then
            self.getCurrentChar().finance.dirtCash = (self.getCurrentChar().finance.dirtCash + amount)
            TriggerClientEvent('pNotify:SetQueueMax', self.source, "global", 5)
            TriggerClientEvent('pNotify:SendNotification', self.source, {
                text = ("$" .. tonumber(amount) .. " dirty cash added!"),
                type = "success",
                layout = "topRight",
                theme = "gta",
                timeout = 1000,
                animation = {
                    open = "noty_effects_open",
                    close = "noty_effects_close",
                },
            })
        end
        TriggerClientEvent('mc:sendUserInfo', self.source, {char_data = self.char_data})
    end

    self.removeDirtCash = function(amount)
        self.getCurrentChar().finance.dirtCash = (self.getCurrentChar().finance.dirtCash - amount) >= 0 and (self.getCurrentChar().finance.dirtCash - amount) or 0
        TriggerClientEvent('pNotify:SetQueueMax', self.source, "global", 5)
        TriggerClientEvent('pNotify:SendNotification', self.source, {
            text = ("$" .. tonumber(amount) .. " dirty cash removed!"),
            type = "error",
            layout = "topRight",
            theme = "gta",
            timeout = 1000,
            animation = {
                open = "noty_effects_open",
                close = "noty_effects_close",
            },
        })
        TriggerClientEvent('mc:sendUserInfo', self.source, {char_data = self.char_data})
    end

    self.getInventoryItem = function(item)
        for i=1, #self.getCurrentChar().inventory, 1 do
            if (self.getCurrentChar().inventory[i].item == item) then
                return self.getCurrentChar().inventory[i], i
            end
        end
        return false
    end

    self.addInventoryItem = function(item, amount)
        local checkedItem, index = self.getInventoryItem(item)

        if (checkedItem) then
            checkedItem.amount = (checkedItem.amount + amount)
        else
            table.insert(self.getCurrentChar().inventory, {item = item, amount = amount})
        end
        TriggerClientEvent('pNotify:SetQueueMax', self.source, "global", 5)
        TriggerClientEvent('pNotify:SendNotification', self.source, {
            text = ("You have recieved " .. tonumber(amount) .. " " .. MC.ItemList[item].label .. "!"),
            type = "success",
            layout = "topRight",
            theme = "gta",
            timeout = 5000,
            animation = {
                open = "noty_effects_open",
                close = "noty_effects_close",
            },
        })
        TriggerClientEvent('mc:sendUserInfo', self.source, {char_data = self.char_data})
    end

    self.removeInventoryItem = function(item, amount)
        local checkedItem, index = self.getInventoryItem(item)

        if (checkedItem) then
            if (checkedItem.amount - amount > 0) then
                self.getCurrentChar().inventory[index].amount = self.getCurrentChar().inventory[index].amount - amount
            else
                table.remove(self.getCurrentChar().inventory, index)
            end
        end
        TriggerClientEvent('pNotify:SetQueueMax', self.source, "global", 5)
        TriggerClientEvent('pNotify:SendNotification', self.source, {
            text = (tonumber(amount) .. " " .. MC.ItemList[item].label .. " have been removed!"),
            type = "error",
            layout = "topRight",
            theme = "gta",
            timeout = 5000,
            animation = {
                open = "noty_effects_open",
                close = "noty_effects_close",
            },
        })
        TriggerClientEvent('mc:sendUserInfo', self.source, {char_data = self.char_data})
    end

	return self
end