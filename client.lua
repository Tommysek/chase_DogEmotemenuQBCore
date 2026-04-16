local animations = {
    { dictionary = "creatures@rottweiler@amb@sleep_in_kennel@",        animation = "sleep_in_kennel",       name = "Lay Down"      },
    { dictionary = "creatures@rottweiler@amb@world_dog_barking@idle_a", animation = "idle_a",               name = "Bark"          },
    { dictionary = "creatures@rottweiler@amb@world_dog_sitting@base",  animation = "base",                  name = "Sit"           },
    { dictionary = "creatures@rottweiler@amb@world_dog_sitting@idle_a", animation = "idle_a",               name = "Itch"          },
    { dictionary = "creatures@rottweiler@indication@",                 animation = "indicate_high",         name = "Draw Attention"},
    { dictionary = "creatures@rottweiler@melee@",                      animation = "dog_takedown_from_back", name = "Attack"       },
    { dictionary = "creatures@rottweiler@melee@streamed_taunts@",      animation = "taunt_02",              name = "Taunt"         },
    { dictionary = "creatures@rottweiler@swim@",                       animation = "swim",                  name = "Swim"          },
}

local dogModels = {
    "a_c_shepherd", "a_c_rottweiler", "a_c_husky", "a_c_poodle", "a_c_pug", "a_c_westy", "a_c_retriever",
    "a_c_chop", "a_c_chop_02", "canine"
}

local emotePlaying = false
local menuOpen = false
local selectedIndex = 1

local function isDog()
    local playerModel = GetEntityModel(GetPlayerPed(-1))
    for i = 1, #dogModels do
        if GetHashKey(dogModels[i]) == playerModel then
            return true
        end
    end
    return false
end

local function cancelEmote()
    ClearPedTasksImmediately(GetPlayerPed(-1))
    emotePlaying = false
end

local function playAnimation(dictionary, animation)
    if emotePlaying then cancelEmote() end
    RequestAnimDict(dictionary)
    while not HasAnimDictLoaded(dictionary) do
        Wait(1)
    end
    TaskPlayAnim(GetPlayerPed(-1), dictionary, animation, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    emotePlaying = true
end

local function drawBox(x, y, w, h, r, g, b, a)
    DrawRect(x, y, w, h, r, g, b, a)
end

local function drawLabel(x, y, scale, r, g, b, a, text, font)
    SetTextFont(font or 4)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

local function openEmoteMenu()
    if menuOpen then return end
    menuOpen = true
    selectedIndex = 1

    CreateThread(function()
        while menuOpen do
            Wait(0)

            local W       = 0.16
            local X       = 1.0 - W / 2 - 0.012
            local startY  = 0.28
            local itemH   = 0.036
            local headerH = 0.040
            local totalRows = #animations + 1
            local bodyH   = totalRows * itemH

            -- Background
            drawBox(X, startY + headerH / 2, W, headerH, 30, 30, 30, 255)
            drawBox(X, startY + headerH, W, 0.002, 255, 255, 255, 40)
            drawBox(X, startY + headerH + bodyH / 2, W, bodyH, 20, 20, 20, 245)

            -- Header title
            drawLabel(X - W / 2 + 0.01, startY + 0.011, 0.28, 255, 255, 255, 255, "Dog Emotes", 4)

            -- Items
            for i = 1, #animations do
                local rowY    = startY + headerH + (i - 1) * itemH
                local centerY = rowY + itemH / 2

                if i == selectedIndex then
                    drawBox(X, centerY, W, itemH, 255, 255, 255, 20)
                    drawBox(X - W / 2 + 0.002, centerY, 0.003, itemH, 100, 180, 255, 255)
                    drawLabel(X - W / 2 + 0.012, rowY + 0.01, 0.27, 255, 255, 255, 255, animations[i].name, 4)
                else
                    drawBox(X, rowY + itemH, W, 0.001, 255, 255, 255, 15)
                    drawLabel(X - W / 2 + 0.012, rowY + 0.01, 0.27, 180, 180, 180, 220, animations[i].name, 4)
                end
            end

            -- Close row
            local closeRowY    = startY + headerH + #animations * itemH
            local closeCenterY = closeRowY + itemH / 2

            if selectedIndex == #animations + 1 then
                drawBox(X, closeCenterY, W, itemH, 255, 255, 255, 20)
                drawBox(X - W / 2 + 0.002, closeCenterY, 0.003, itemH, 255, 80, 80, 255)
                drawLabel(X - W / 2 + 0.012, closeRowY + 0.01, 0.27, 255, 100, 100, 255, "Close", 4)
            else
                drawBox(X, closeRowY + itemH, W, 0.001, 255, 255, 255, 15)
                drawLabel(X - W / 2 + 0.012, closeRowY + 0.01, 0.27, 150, 150, 150, 200, "Close", 4)
            end

            -- Navigation input
            if IsControlJustReleased(0, 172) then
                selectedIndex = selectedIndex - 1
                if selectedIndex < 1 then selectedIndex = #animations + 1 end
            end
            if IsControlJustReleased(0, 173) then
                selectedIndex = selectedIndex + 1
                if selectedIndex > #animations + 1 then selectedIndex = 1 end
            end
            if IsControlJustReleased(0, 201) or IsControlJustReleased(0, 191) then
                if selectedIndex == #animations + 1 then
                    menuOpen = false
                else
                    menuOpen = false
                    playAnimation(animations[selectedIndex].dictionary, animations[selectedIndex].animation)
                end
            end
            if IsControlJustReleased(0, 202) or IsControlJustReleased(0, 200) then
                menuOpen = false
            end
        end
    end)
end

RegisterKeyMapping('pedemote_open', 'Open Dog Emote Menu', 'keyboard', 'j')

RegisterCommand('pedemote_open', function()
    if not isDog() then return end
    openEmoteMenu()
end, false)

CreateThread(function()
    while true do
        Wait(0)
        if emotePlaying then
            if IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35) then
                cancelEmote()
            end
        end
    end
end)