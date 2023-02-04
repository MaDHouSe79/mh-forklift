--[[ ===================================================== ]]--
--[[             MH Forklift Script by MaDHouSe            ]]--
--[[ ===================================================== ]]--

local Translations = {
    notify = {
        ['press_attach'] = "Press [~g~%{key}~s~] to attach this vehicle",
        ['press_detach'] = "Press [~g~%{key}~s~] to detach this vehicle",
        ['can_not_lift_vehicle'] = "You cannot lift this vehicle!",
        ['press_to_use_lift'] = "Use [~g~%{key1}~s~] for up and [~g~%{key2}~s~] for down",
        ['attached'] = "Vehicle is attached",
        ['detached'] = "Vehicle is detached",
    },
    text = {
        key1 = "NUML 8",
        key2 = "NUML 6"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})