ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
end)

local MenuAscenseur = RageUI.CreateMenu("Ascenseur", 'menu ascenseur');

function RageUI.PoolMenus:Ascenseur()
    MenuAscenseur:IsVisible(function(Items)
        for i = 1, #ConfigAscenseur do
        local v = ConfigAscenseur[i]
            Items:AddButton(v.Nom, nil, {RightLabel = ">", IsDisabled = false }, function(onSelected)
                if (onSelected) then
                    SetEntityCoords(GetPlayerPed(-1), v.position.x, v.position.y, v.position.z)
                end
            end)
        end
    end, function(Panels)
    end)
end

Citizen.CreateThread(function()
	while true do
        wait = 500
        local playerCoords = GetEntityCoords(PlayerPedId())
        for i = 1, #ConfigAscenseur do
            local v = ConfigAscenseur[i]
            local distancevestiaire = GetDistanceBetweenCoords(playerCoords, v.position.x, v.position.y, v.position.z, true)
            if distancevestiaire <= 5.0 then
                wait = 0
                DrawMarker(6, v.position.x, v.position.y, v.position.z-1, 0.0, 0.0, 9.0, 0.0, 0.0, 0.0, 0.5, 1.0, 0.5, 114, 204, 114, 250, false, false, 2, false, false, false, false)
            end
            if distancevestiaire <= 1.0 then
                wait = 0
                ESX.ShowHelpNotification("Appuyer sur ~g~[E]~s~ pour acceder à ~g~l'ascenseur", 1) 
                if IsControlJustPressed(1, 51) then
                    RageUI.Visible(MenuAscenseur, not RageUI.Visible(MenuAscenseur))
                end
            end
        end
        Citizen.Wait(wait)
	end
end)