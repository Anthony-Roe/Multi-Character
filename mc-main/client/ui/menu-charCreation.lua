MC.Menu["charCreation"] = NativeUI.CreateMenu("Character Creation", "Multi-Character", 0,0)
MC.Menu["charCreation"].Controls.Back.Enabled = false
_menuPool:Add(MC.Menu["charCreation"])

local MixAmount = {}
for i=1,9 do
    table.insert(MixAmount, {Value = tonumber("0."..i)})
end

local momfaces = {}
for i=0,21 do
    table.insert(momfaces, {Name = i, Value = i})
end

local dadfaces = {}
for i=0,23 do
    table.insert(dadfaces, {Name = i, Value = i})
end

local beardAmount = {}
for i=0,28 do
    table.insert(beardAmount, {Name = i, Value = i})
end

local eyebrowAmount = {}
for i=0,33 do
    table.insert(eyebrowAmount, {Name = i, Value = i})
end

local ageingAmount = {}
for i=0,14 do
    table.insert(ageingAmount, {Name = i, Value = i})
end

local blemishesAmount = {}
for i=0,23 do
    table.insert(blemishesAmount, {Name = i, Value = i})
end

local complexionAmount = {}
for i=0,11 do
    table.insert(complexionAmount, {Name = i, Value = i})
end

local lipstickAmount = {}
for i=0,9 do
    table.insert(lipstickAmount, {Name = i, Value = i})
end

local makeupAmount = {}
for i=0,74 do
    table.insert(makeupAmount, {Name = i, Value = i})
end

local eyecolorAmount = {}
for i=0,31 do
    table.insert(eyecolorAmount, {Name = i, Value = i})
end

local hairAmount = {}
for i=0,36 do
    table.insert(hairAmount, {Name = i, Value = i})
end

local hairColorAmount = {}
for i=0,63 do
    hairColorAmount[i] = i - 1
end

local Colors = {
    {22, 19, 19}, -- 0
    {30, 28, 25}, -- 1
    {76, 56, 45}, -- 2
    {69, 34, 24}, -- 3
    {123, 59, 31}, -- 4
    {149, 68, 35}, -- 5
    {165, 87, 50}, -- 6
    {175, 111, 72}, -- 7
    {159, 105, 68}, -- 8
    {198, 152, 108}, -- 9
    {213, 170, 115}, -- 10
    {223, 187, 132}, -- 11
    {202, 164, 110}, -- 12
    {238, 204, 130}, -- 13
    {229, 190, 126}, -- 14
    {250, 225, 167}, -- 15
    {187, 140, 96}, -- 16
    {163, 92, 60}, -- 17
    {144, 52, 37}, -- 18
    {134, 21, 17}, -- 19
    {164, 24, 18}, -- 20
    {195, 33, 24}, -- 21
    {221, 69, 34}, -- 22
    {229, 71, 30}, -- 23
    {208, 97, 56}, -- 24
    {113, 79, 38}, -- 25
    {132, 107, 95}, -- 26
    {185, 164, 150}, -- 27
    {218, 196, 180}, -- 28
    {247, 230, 217}, -- 29
    {102, 72, 93}, -- 30
    {162, 105, 138}, -- 31
    {171, 174, 11}, -- 32
    {239, 61, 200}, -- 33
    {255, 69, 152}, -- 34
    {255, 178, 191}, -- 35
    {12, 168, 146}, -- 36
    {8, 146, 165}, -- 37
    {11, 82, 134}, -- 38
    {118, 190, 117}, -- 39
    {52, 156, 104}, -- 40
    {22, 86, 85}, -- 41
    {152, 177, 40}, -- 42
    {127, 162, 23}, -- 43
    {241, 200, 98}, -- 44
    {238, 178, 16}, -- 45
    {224, 134, 14}, -- 46
    {247, 157, 15}, -- 47
    {243, 143, 16}, -- 48
    {231, 70, 15}, -- 49
    {255, 101, 21}, -- 50
    {254, 91, 34}, -- 51
    {252, 67, 21}, -- 52
    {196, 12, 15}, -- 53
    {143, 10, 14}, -- 54
    {44, 27, 22}, -- 55
    {80, 51, 37}, -- 56
    {98, 54, 37}, -- 57
    {60, 31, 24}, -- 58
    {69, 43, 32}, -- 59
    {8, 10, 14}, -- 60
    {212, 185, 158}, -- 61
    {212, 185, 158}, -- 62
    {213, 170, 115}, -- 63
}


local sex = {"Male", "Female"}

MC.Menu["charCreation"].GenerateMenu = function()
    MC.Menu["charCreation"]:Clear()
    local data = {info = {firstname = "FIRST", lastname = "LAST"}, skin = {sex = "Male", model = "mp_m_freemode_01", face = {mom = 0, dad = 0}, resemblance = 0.0, skinmix = 0.0, ageing = {style = 0, opacity = 0.0}, lipstick = {style = 0, opacity = 0.0, color = { [1] = 0, [2] = 0}}, eye = {style = 0}, blemishes = {style = 0, opacity = 0.0}, complexion = {style = 0, opacity = 0.0}, makeup = {style = 0, opacity = 0.0}, hair = {style = 0, color = {[1] = 0, [2] = 0}}, facialHair = { beard = {style = 0, color = {[1] = 0, [2] = 0}, opacity = 0.0}, eyebrow = {style = 0, color = {[1] = 0, [2] = 0}, opacity = 0.0}}}}

    MC.Func.FM.updateFace(data.skin)

    local sexSelect = NativeUI.CreateListItem("Sex", sex, 1)
    MC.Menu["charCreation"]:AddItem(sexSelect)
    local characterDetails = _menuPool:AddSubMenu(MC.Menu["charCreation"], "Character Info", "", true)
        local firstName = NativeUI.CreateItem("First Name:", "Set your first name.")
        local lastName = NativeUI.CreateItem("Last Name:", "Set your last name.")

    local heritageMenu = _menuPool:AddSubMenu(MC.Menu["charCreation"], "Heritage", "", true)
        local heritageWindow = NativeUI.CreateHeritageWindow(0, 0)
        local momSelect = NativeUI.CreateListItem("Mom", momfaces, 0)
        local dadSelect = NativeUI.CreateListItem("Dad", dadfaces, 0)
        local resSlider = NativeUI.CreateSliderItem("Resemblance", MixAmount, 0, "Mom <-> Dad", true)
        local skinSlider = NativeUI.CreateSliderItem("Skin Tone", MixAmount, 0, "Mom <-> Dad", true)

    local appearanceMenu = _menuPool:AddSubMenu(MC.Menu["charCreation"], "Appearance", "", true)
        local hairSelect = NativeUI.CreateListItem("Hair", hairAmount, 0)
            local hairBaseColor = NativeUI.CreateColourPanel("Hair Base Color", Colors)
            local hairHighColor = NativeUI.CreateColourPanel("Hair Highlight Color", Colors)
        local beardSelect = NativeUI.CreateListItem("Beard", beardAmount, 0)
            local beardOpacity = NativeUI.CreatePercentagePanel("Beard Opacity", "0%", "100%")
            local beardBaseColor = NativeUI.CreateColourPanel("Beard Base Color", Colors)
            local beardHighColor = NativeUI.CreateColourPanel("Beard Highlight Color", Colors)
        local eyebrowSelect = NativeUI.CreateListItem("Eyebrow", eyebrowAmount, 0)
            local eyebrowOpacity = NativeUI.CreatePercentagePanel("Eyebrow Opacity", "0%", "100%")
            local eyebrowBaseColor = NativeUI.CreateColourPanel("Eyebrow Base Color", Colors)
            local eyebrowHighColor = NativeUI.CreateColourPanel("Eyebrow Highlight Color", Colors)
        local ageingSelect = NativeUI.CreateListItem("Skin Ageing", ageingAmount, 0)
            local ageingOpacity = NativeUI.CreatePercentagePanel("Ageing Opacity", "0%", "100%")
        local blemishesSelect = NativeUI.CreateListItem("Skin Blemishes", blemishesAmount, 0)
            local blemishesOpacity = NativeUI.CreatePercentagePanel("Blemishes Opacity", "0%", "100%")
        local complexionSelect = NativeUI.CreateListItem("Skin Complexion", complexionAmount, 0)
            local complexionOpacity = NativeUI.CreatePercentagePanel("Complexion Opacity", "0%", "100%")
        local lipstickSelect = NativeUI.CreateListItem("Lipstick", lipstickAmount, 0)
            local lipstickOpacity = NativeUI.CreatePercentagePanel("Lipstick Opacity", "0%", "100%")
            local lipstickBaseColor = NativeUI.CreateColourPanel("Lipstick Color", Colors)
        local makeupSelect = NativeUI.CreateListItem("Makeup", makeupAmount, 0)
            local makeupOpacity = NativeUI.CreatePercentagePanel("Makeup Opacity", "0%", "100%")
        local eyecolorSelect = NativeUI.CreateListItem("Eye Color", eyecolorAmount, 0)

        local finishCreation = NativeUI.CreateItem("Finish Character", "")

    --[[ Freemode Character ]]--
    --== START: Character Details ==--
    -- First Name
    characterDetails:AddItem(firstName)
    firstName:RightLabel(data.info.firstname)
    firstName.Activated = function(ParentMenu, SelectedItem)
        data.info.firstname = MC.Func.Input("Whats your first name?", "", 15)
        firstName:RightLabel(data.info.firstname)
    end

    -- Last Name
    characterDetails:AddItem(lastName)
    lastName:RightLabel(data.info.lastname)
    lastName.Activated = function(ParentMenu, SelectedItem)
        data.info.lastname = MC.Func.Input("Whats your last name?", "", 15)
        lastName:RightLabel(data.info.lastname)
    end

    --== END: Character Details ==--
    
    --== START: SEX ==--
    sexSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local item = SelectedItem:IndexToItem(Index)
        data.skin.sex = item
        -- TO DO: Change players sex
        if data.skin.sex == "Male" then
            data.skin.model = "mp_m_freemode_01"
            hairAmount = {}
            for i=0,36 do
                table.insert(hairAmount, {Name = i, Value = i})
            end
            hairSelect:UpdateItems(hairAmount)
        elseif data.skin.sex == "Female" then
            data.skin.model = "mp_f_freemode_01"
            hairAmount = {}
            for i=0,77 do
                table.insert(hairAmount, {Name = i, Value = i})
            end
            hairSelect:UpdateItems(hairAmount)
        end
        MC.Func.FM.updateModel(GetHashKey(data.skin.model))
        MC.Func.FM.updateFace(data.skin)
    end

    --== END: SEX ==--

    --== START: Heritage ==--
	heritageMenu:AddWindow(heritageWindow)
    heritageMenu:AddItem(momSelect)
    momSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local item = SelectedItem:IndexToItem(Index)
        data.skin.face.mom = item.Value
        heritageWindow:Index(data.skin.face.mom, data.skin.face.dad)
        MC.Func.FM.updateFace(data.skin)
    end

    heritageMenu:AddItem(dadSelect)
    dadSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local item = SelectedItem:IndexToItem(Index)
        data.skin.face.dad = item.Value
        heritageWindow:Index(data.skin.face.mom, data.skin.face.dad)
        MC.Func.FM.updateFace(data.skin)
    end

    heritageMenu:AddItem(resSlider)
    resSlider.OnSliderChanged = function(ParentMenu, SelectedItem, Index)
        local item = SelectedItem:IndexToItem(Index)
        data.skin.resemblance = item.Value
        MC.Func.FM.updateFace(data.skin)
    end

    heritageMenu:AddItem(skinSlider)
    skinSlider.OnSliderChanged = function(ParentMenu, SelectedItem, Index)
        local item = SelectedItem:IndexToItem(Index)
        data.skin.skinmix = item.Value
        MC.Func.FM.updateFace(data.skin)
    end

    --== END: Heritage ==--

    --== START: Appearance ==--

    hairSelect:AddPanel(hairBaseColor)
    hairSelect:AddPanel(hairHighColor)
    appearanceMenu:AddItem(hairSelect)
    hairSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local ActiveItem = SelectedItem:IndexToItem(Index)
        data.skin.hair.style = ActiveItem.Value
        data.skin.hair.color[1] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1) - 1
        data.skin.hair.color[2] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1
        MC.Func.FM.updateFace(data.skin)
    end

    beardSelect:AddPanel(beardOpacity)
    beardOpacity:Percentage(0.0)
    beardSelect:AddPanel(beardBaseColor)
    beardSelect:AddPanel(beardHighColor)
    appearanceMenu:AddItem(beardSelect)
    beardSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local ActiveItem = SelectedItem:IndexToItem(Index)
        data.skin.facialHair.beard.style = ActiveItem.Value
        data.skin.facialHair.beard.opacity = (ActiveItem.Panels and ActiveItem.Panels[1] or 0.0)
        data.skin.facialHair.beard.color[1] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1
        data.skin.facialHair.beard.color[2] = (ActiveItem.Panels and ActiveItem.Panels[3] or 1) - 1
        MC.Func.FM.updateFace(data.skin)
    end

    eyebrowSelect:AddPanel(eyebrowOpacity)
    eyebrowOpacity:Percentage(0.0)
    eyebrowSelect:AddPanel(eyebrowBaseColor)
    eyebrowSelect:AddPanel(eyebrowHighColor)
    appearanceMenu:AddItem(eyebrowSelect)
    eyebrowSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local ActiveItem = SelectedItem:IndexToItem(Index)
        data.skin.facialHair.eyebrow.style = ActiveItem.Value
        data.skin.facialHair.eyebrow.opacity = (ActiveItem.Panels and ActiveItem.Panels[1] or 0.0)
        data.skin.facialHair.eyebrow.color[1] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1
        data.skin.facialHair.eyebrow.color[2] = (ActiveItem.Panels and ActiveItem.Panels[3] or 1) - 1
        MC.Func.FM.updateFace(data.skin)
    end

    ageingSelect:AddPanel(ageingOpacity)
    ageingOpacity:Percentage(0.0)
    appearanceMenu:AddItem(ageingSelect)
    ageingSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local ActiveItem = SelectedItem:IndexToItem(Index)
        data.skin.ageing.style = ActiveItem.Value
        data.skin.ageing.opacity = (ActiveItem.Panels and ActiveItem.Panels[1] or 0.0)
        MC.Func.FM.updateFace(data.skin)
    end

    blemishesSelect:AddPanel(blemishesOpacity)
    blemishesOpacity:Percentage(0.0)
    appearanceMenu:AddItem(blemishesSelect)
    blemishesSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local ActiveItem = SelectedItem:IndexToItem(Index)
        data.skin.blemishes.style = ActiveItem.Value
        data.skin.blemishes.opacity = (ActiveItem.Panels and ActiveItem.Panels[1] or 0.0)
        MC.Func.FM.updateFace(data.skin)
    end

    complexionSelect:AddPanel(complexionOpacity)
    complexionOpacity:Percentage(0.0)
    appearanceMenu:AddItem(complexionSelect)
    complexionSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local ActiveItem = SelectedItem:IndexToItem(Index)
        data.skin.blemishes.style = ActiveItem.Value
        data.skin.blemishes.opacity = (ActiveItem.Panels and ActiveItem.Panels[1] or 0.0)
        MC.Func.FM.updateFace(data.skin)
    end

    lipstickSelect:AddPanel(lipstickOpacity)
    lipstickOpacity:Percentage(0.0)
    lipstickSelect:AddPanel(lipstickBaseColor)
    appearanceMenu:AddItem(lipstickSelect)
    lipstickSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local ActiveItem = SelectedItem:IndexToItem(Index)
        data.skin.lipstick.style = ActiveItem.Value
        data.skin.lipstick.opacity = (ActiveItem.Panels and ActiveItem.Panels[1] or 0.0)
        data.skin.lipstick.color[1] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1
        data.skin.lipstick.color[2] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1
        MC.Func.FM.updateFace(data.skin)
    end

    makeupSelect:AddPanel(makeupOpacity)
    makeupOpacity:Percentage(0.0)
    appearanceMenu:AddItem(makeupSelect)
    makeupSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local ActiveItem = SelectedItem:IndexToItem(Index)
        data.skin.makeup.style = ActiveItem.Value
        data.skin.makeup.opacity = (ActiveItem.Panels and ActiveItem.Panels[1] or 0.0)
        MC.Func.FM.updateFace(data.skin)
    end

    appearanceMenu:AddItem(eyecolorSelect)
    eyecolorSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)
        local ActiveItem = SelectedItem:IndexToItem(Index)
        data.skin.eye.style = ActiveItem.Value
        MC.Func.FM.updateFace(data.skin)
    end

    finishCreation:SetRightBadge(BadgeStyle.Tick)
    MC.Menu["charCreation"]:AddItem(finishCreation)
    finishCreation.Activated = function(ParentMenu, SelectedItem)
        _menuPool:CloseAllMenus()
        local finalData = {
            id = (#MC.Data.char_data + 1),
            name = {firstname = data.info.firstname, lastname = data.info.lastname},
            finance = {cash = 0, bank = 0, dirtCash = 0},
            job = {name = "unemployed", grade = 0},
            skin = data.skin,
            inventory = {},
        }
        TriggerServerEvent('mc:finishChar', finalData)
    end
    --== END: Appearance ==--
end