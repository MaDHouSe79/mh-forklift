--[[ ===================================================== ]]--
--[[             MH Forklift Script by MaDHouSe            ]]--
--[[ ===================================================== ]]--
-- placeholder
Config = {}

-- if true, this means the forklift can not move or drive if you want to use the lift.
Config.ForkliftMustBeStationaryBeforeUsing = true 

-- vehicle forklift model
Config.ForkliftModel = `forklift`                 

-- E Key Interaction to attach/detach
Config.Interact = {
    key = 38, 
    text = "E"
}          

-- vehicles that you can't lift.
Config.Blacklisted = {
    ["adder"] = false,
}
