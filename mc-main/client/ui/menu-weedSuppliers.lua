MC.Menu["weedSuppliers"] = NativeUI.CreateMenu("Supplier", "Multi-Character", 0,0)
MC.Menu["weedSuppliers"]:DisEnableControls(true)
_menuPool:Add(MC.Menu["weedSuppliers"])

local buyAmount = {}
for i=0, 50, 1 do
    table.insert(buyAmount, {Name = i, Value = i})
end

MC.Menu["weedSuppliers"].GenerateMenu = function(supplies)
    MC.Menu["weedSuppliers"]:Clear()
    for i=1, #supplies do
        local amountToBuy = 0
        local item = MC.ItemList[supplies[i]]
        local itemSubMenu = _menuPool:AddSubMenu(MC.Menu["weedSuppliers"], item.label, item.buy.description, true, true)
        local amountList = NativeUI.CreateListItem("Amount to buy", buyAmount, 0)
        local buyButton = NativeUI.CreateItem("Checkout", item.sell.description)
        itemSubMenu:AddItem(amountList)
        itemSubMenu:AddItem(buyButton)
        buyButton:RightLabel("$" .. item.buyPrice * amountToBuy)
        amountList.OnListChanged = function(ParentMenu, SelectedItem, Index)
            local ActiveItem = SelectedItem:IndexToItem(Index)
            amountToBuy = ActiveItem.Value
            buyButton:RightLabel("$" .. (item.buyPrice * amountToBuy))
        end
        buyButton.Activated = function(ParentMenu, SelectedItem)
            TriggerServerEvent("mc:buyItem", supplies[i], amountToBuy)
        end
    end
end