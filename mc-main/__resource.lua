resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

server_scripts {

    --[[ Database ]]--
    "server/functions/db/db-frame.lua",
    "server/functions/db/db-main.lua",

    --[[ Main Functions ]]--
    "server/functions/util-functions.lua",
    "server/functions/util-events.lua",
    "server/classes/player.lua",

    "server/main.lua",

    "shared/main.lua",
}

client_scripts {

    --[[ Main Functions ]]--
    "client/functions/util-functions.lua",
    "client/functions/util-events.lua",

    --[[ UI ]]--
    "@NativeUI/NativeUI.lua",
    "client/ui/menu-main.lua",
    
    "client/ui/menu-charSelection.lua",
    "client/ui/menu-charCreation.lua",
    "client/ui/menu-playerInventory.lua",
    "client/ui/menu-weedSuppliers.lua",

    --[[ Commands ]]--


    "client/main.lua",

    "shared/main.lua",
}


exports {
    'GetClientData',
    'GetCharInventory',
}

server_export {
    'GetClientData'
}