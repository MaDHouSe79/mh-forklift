--[[ ===================================================== ]]--
--[[             MH Forklift Script by MaDHouSe            ]]--
--[[ ===================================================== ]]--

local Translations = {
    notify = {
        ['press_attach'] = "Druk [~g~%{key}~s~] om het voertuig vast te zetten",
        ['press_detach'] = "Druk [~g~%{key}~s~] om het voertuig los te maken.",
        ['can_not_lift_vehicle'] = "Je kunt dit voertuig niet opliften!",
        ['press_to_use_lift'] = "Gebruik [~g~%{key1}~s~] voor omhoog en [~g~%{key2}~s~] voor omlaag",
        ['attached'] = "Voertuig is bevestigd",
        ['detached'] = "Voertuig is losgemaakt",
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