_menuPool = NativeUI.CreatePool()

Citizen.CreateThread(function()
    while true do
        _menuPool:ProcessMenus()
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(0, 166) then
            print('sent')
            TriggerEvent("mc:openMenu", "playerInventory")
        end
        Citizen.Wait(10)
    end
end)

RegisterNetEvent('mc:openMenu')
AddEventHandler('mc:openMenu', function(menu, data)
    if (menu and type(menu) == "string") then
        _menuPool:CloseAllMenus()
        MC.Menu[menu].GenerateMenu(data)
        MC.Menu[menu]:Visible(not MC.Menu[menu]:Visible())
    end
end)