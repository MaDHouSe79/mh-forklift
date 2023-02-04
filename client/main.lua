--[[ ===================================================== ]]--
--[[             MH Forklift Script by MaDHouSe            ]]--
--[[ ===================================================== ]]--

local QBCore = exports['qb-core']:GetCoreObject()
local isAttached = false
local attachedEntity = nil
local showPopup = false

local function DrawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

local function isPlayerInForkliftVehicle()
	local isInForklift = false
	if IsPedInAnyVehicle(PlayerPedId()) then
		local forklift = GetVehiclePedIsIn(PlayerPedId(), false)		
		if GetEntityModel(forklift) == Config.ForkliftModel then
			isInForklift = true
		end
	end
	return isInForklift
end

local function DisplayMessage()	
	if isPlayerInForkliftVehicle() then
		if not isAttached and IsPedInAnyVehicle(PlayerPedId()) and GetEntityModel(GetVehiclePedIsIn(PlayerPedId())) == Config.ForkliftModel then
			showPopup = (GetClosestVehicle(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0), 2.0, 0, 70) ~= 0) 
		else 
			showPopup = false 
		end
		if showPopup then
			if not isAttached then DrawTxt(0.89, 1.44, 1.0, 1.0, 0.6, Lang:t('notify.press_attach', {key = Config.Interact.text}), 255, 255, 255, 255) end
		else
			if isAttached then 
				DrawTxt(0.89, 1.40, 1.0, 1.0, 0.6, Lang:t('notify.press_detach', {key = Config.Interact.text}), 255, 255, 255, 255) 
				DrawTxt(0.85, 1.44, 1.0, 1.0, 0.6, Lang:t('notify.press_to_use_lift', {key1 = Lang:t('text.key1'), key2 = Lang:t('text.key2'), key3 = Config.Interact.text}), 255, 255, 255, 255) 
			end
		end
	end
end

local function Reset()
	attachedEntity = nil
	isAttached = false
	showPopup = false
end

local function AttachToForklift(target, forklift)
	showPopup = false
	attachedEntity = target
	AttachEntityToEntity(target, forklift, 3, 0.0, 1.3, -0.09, 0.0, 0, 90.0, false, false, false, false, 2, true)
end

local function Toggle()
	if isAttached then
		DetachEntity(attachedEntity, true, true)
		attachedEntity = nil
		isAttached = false
		QBCore.Functions.Notify(Lang:t('notify.detached'), "success")
	else
		local target = GetClosestVehicle(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0), 2.0, 0, 70)
		if target ~= 0 then
			local props = QBCore.Functions.GetVehicleProperties(target)
			local displaytext = GetDisplayNameFromVehicleModel(props.model)
			if Config.Blacklisted[displaytext:lower()] then
				Reset()
				QBCore.Functions.Notify(Lang:t('notify.can_not_lift_vehicle'), "error")
			else	
				isAttached = true
				AttachToForklift(target, GetVehiclePedIsIn(PlayerPedId(), false))
				QBCore.Functions.Notify(Lang:t('notify.attached'), "success")
			end
		end
	end
end

CreateThread(function()
    while true do
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			local target = GetClosestVehicle(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0), 2.0, 0, 70)
			if target ~= 0 then
				local forklift = GetVehiclePedIsIn(PlayerPedId(), false)		
				if GetEntityModel(forklift) == Config.ForkliftModel then
					local props = QBCore.Functions.GetVehicleProperties(target)
					local displaytext = GetDisplayNameFromVehicleModel(props.model)
					if not Config.Blacklisted[displaytext:lower()] then
						local enable = false
						if Config.ForkliftMustBeStationaryBeforeUsing then
							local speed = GetEntitySpeed(forklift)
							if speed <= 0.1 then enable = true end
						else
							enable = true
						end
						if enable then
							DisplayMessage()
							if IsControlJustPressed(0, Config.Interact.key) then 
								Toggle() 
							end
						end
					end
				end
			end
		end
		Wait(0)
    end
end)
