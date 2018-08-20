MC.Menu["playerInventory"] = NativeUI.CreateMenu("Inventory", "Multi-Character", 0,0)
_menuPool:Add(MC.Menu["playerInventory"])

MC.Menu["playerInventory"].GenerateMenu = function()
    Citizen.CreateThread(function()
        MC.Menu["playerInventory"]:Clear()
        local inventory = MC.Data.getCharInventory(MC.Data.char_current)
        print(json.encode(inventory))
        if (#inventory > 0) then
            for i=1, #inventory, 1 do
                local item = inventory[i]
                local newItemMenu = _menuPool:AddSubMenu(MC.Menu["playerInventory"], "[Amount: " .. item.amount .. "] " .. MC.ItemList[item.item].label, MC.ItemList[item.item].description, true, true)
                if (MC.ItemList[item.item].use) then
                    local useButton = NativeUI.CreateItem(MC.ItemList[item.item].use.label, MC.ItemList[item.item].use.description)
                    newItemMenu:AddItem(useButton)
                end
                if (MC.ItemList[item.item].give) then
                    local giveButton = NativeUI.CreateItem(MC.ItemList[item.item].give.label, MC.ItemList[item.item].give.description)
                    newItemMenu:AddItem(giveButton)
                end
                if (MC.ItemList[item.item].drop) then
                    local dropButton = NativeUI.CreateItem(MC.ItemList[item.item].drop.label, MC.ItemList[item.item].drop.description)
                    newItemMenu:AddItem(dropButton)
                end
            end
        else
            local noItemsButton = NativeUI.CreateItem("You have no inventory items.", "")
            MC.Menu["playerInventory"]:AddItem(noItemsButton)
        end
        return
    end)
end