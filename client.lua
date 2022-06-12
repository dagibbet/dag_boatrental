local keys = { ['O'] = 0xF1301666, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9 }

local pressTime = 0
local pressLeft = 0

local recentlySpawned = 0

local boatModel;
local boatSpawn = {}
local NumberboatSpawn = 0

local boating = false
local isAnchored = false

--Config Boats Here

local boates = {
	[1] = {
		['Text'] = "$5 Row Boat",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Row Boat",
			['Price'] = 5,
			['Model'] = "rowboat",
		}
	},

	[2] = {
		['Text'] = "$5 Skiff",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Row Boat",
			['Price'] = 5,
			['Model'] = "rowboat",
		}
	},

	[3] = {
		['Text'] = "$5 Swamp Row Boat",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Swamp Row Boat",
			['Price'] = 5,
			['Model'] = "rowboatSwamp",
		}
	},

	[4] = {
		['Text'] = "$5 Swamp Row Boat 2",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Swamp Row Boat 2",
			['Price'] = 5,
			['Model'] = "rowboatSwamp02",
		}
	},

	[5] = {
		['Text'] = "$8 Regular Canoe",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Regular Canoe",
			['Price'] = 8,
			['Model'] = "CANOE",
		}
	},

	[6] = {
		['Text'] = "$10 Pirogue Boat",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Pirogue Boat",
			['Price'] = 10,
			['Model'] = "pirogue",
		}
	},

	[7] = {
		['Text'] = "$10 Pirogue 2 Boat",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Pirogue Boat",
			['Price'] = 10,
			['Model'] = "pirogue2",
		}
	},

	[8] = {
		['Text'] = "$5 Tree Trunk Canoe",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Tree Trunk Canoe",
			['Price'] = 5,
			['Model'] = "CANOETREETRUNK",
		}
	},

	[9] = {
		['Text'] = "$20 Steam Boat",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Steam Boat",
			['Price'] = 20,
			['Model'] = "KEELBOAT",
		}
	},

	[10] = {
		['Text'] = "$20 Modern Steam Boat",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Name'] = "Modern Steam Boat",
			['Price'] = 20,
			['Model'] = "boatsteam02x",
		}
	},

	-- [11] = {
		-- ['Text'] = "$20 Horse Boat",
		-- ['SubText'] = "",
		-- ['Desc'] = "",
		-- ['Param'] = {
			-- ['Name'] = "horse Boat",
			-- ['Price'] = 20,
			-- ['Model'] = "horseBoat",
		-- }
	-- },
	-- [12] = {
		-- ['Text'] = "$20 Tug Boat",
		-- ['SubText'] = "",
		-- ['Desc'] = "",
		-- ['Param'] = {
			-- ['Name'] = "Modern Tug Boat",
			-- ['Price'] = 20,
			-- ['Model'] = "TugBoat2",
		-- }
	-- },

}

local function DisplayHelp(_message, x, y, w, h, enableShadow, col1, col2, col3, a, centre )

	local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

	SetTextScale(w, h)
	SetTextColor(col1, col2, col3, a)

	SetTextCentre(centre)

	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end

	Citizen.InvokeNative(0xADA9255D, 10);

	DisplayText(str, x, y)

end

local function ShowNotification( _message )
	local timer = 200
	while timer > 0 do
		DisplayHelp(_message, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
		Citizen.Wait(0)
	end
end

Citizen.CreateThread( function()
	WarMenu.CreateMenu('id_boat', 'Boats')
	repeat
		if WarMenu.IsMenuOpened('id_boat') then
			for i = 1, #boates do
				if WarMenu.Button(boates[i]['Text'], boates[i]['SubText'], boates[i]['Desc']) then
					TriggerServerEvent('dag_boatrental:server:buyboat', boates[i]['Param'])
					Citizen.Wait(500)
					WarMenu.CloseMenu()
				end
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	until false
end)

function OpenBoatsMenu()
    WarMenu.OpenMenu('Boats_MainMenu')
end

Citizen.CreateThread(function(HasBoats)
	WarMenu.CreateMenu('Boats_MainMenu', 'Boat Menu')
	WarMenu.SetSubTitle('Boats_MainMenu', "Boat Menu")
	WarMenu.CreateSubMenu('Boats', 'Boats_MainMenu', 'Rent a Boat')
	WarMenu.CreateSubMenu('Exit', 'Boats_MainMenu', 'Exit Boat Menu')

    while true do
        Citizen.Wait(0)
        if WarMenu.IsMenuOpened('Boats_MainMenu') then
			if WarMenu.MenuButton('Rent Boat', 'Boats') then
				OpenBuyBoatsMenu()
			end

			if WarMenu.MenuButton('Exit', 'Exit') then
				WarMenu.CloseMenu()
				Wait(600)
			end

            WarMenu.Display()
        end
    end
end)

function OpenBuyBoatsMenu()
	WarMenu.OpenMenu('id_boat')
end

-- | Prompts | --

Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('saint_denis_br', vector3(2812.66, -1448.09, 42.80), 0x760A9C6F, 'Rent Boat', {
            type = 'client',
            event = 'dag_boatrental:cient:openMenu',
            args = {},
        })
	exports['qbr-core']:createPrompt('annesburg_br', vector3(3033.23, 1369.64, 42.62), 0x760A9C6F, 'Rent Boat', {
            type = 'client',
            event = 'dag_boatrental:cient:openMenu',
            args = {},
        })
	exports['qbr-core']:createPrompt('blackwater_br', vector3(-682.36, -1242.97, 43.11), 0x760A9C6F, 'Rent Boat', {
            type = 'client',
            event = 'dag_boatrental:cient:openMenu',
            args = {},
        })
	
end)

RegisterNetEvent('dag_boatrental:cient:openMenu')
AddEventHandler('dag_boatrental:cient:openMenu', function()
	OpenBoatsMenu()
end)

-- | Blips | --

Citizen.CreateThread(function()
    for _,marker in pairs(Config.Marker) do
        local blip = N_0x554d9d53f696d002(1664425300, marker.x, marker.y, marker.z)
        SetBlipSprite(blip, marker.sprite, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, marker.name)
    end  
end)


-- | Notification | --

RegisterNetEvent('UI:DrawNotification')
AddEventHandler('UI:DrawNotification', function(_message)
	ShowNotification(_message)
end)

-- | Get Current Town Name, Some Towns missing | --
function GetCurrentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords ,1)
    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
    else
        return ""
    end
end

-- | Boat Storage | --
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		if IsControlJustReleased(0, keys['O']) then
			if IsPedInAnyBoat(PlayerPedId()) then
				OpenBoatMenu()
			else
				return
			end
		end
	end
end)

function OpenBoatMenu()
	if boating == true then
		WarMenu.OpenMenu('MobileBoatMenu')
	else
		return
	end
end

Citizen.CreateThread(function()
	WarMenu.CreateMenu('MobileBoatMenu', 'Boat Menu')
	WarMenu.SetSubTitle('MobileBoatMenu', 'Boat Menu')
    while true do
        Citizen.Wait(0)
        if WarMenu.IsMenuOpened('MobileBoatMenu') then
            WarMenu.Display()
			if WarMenu.Button("Store Boat") then
				WarMenu.CloseMenu()
                TaskLeaveVehicle(PlayerPedId(), spawn_boat, 0)
                Wait(2200)
				DeleteEntity(spawn_boat)
				WarMenu.Display()
				boating = false
			elseif WarMenu.Button("Anchor Boat") then
				WarMenu.CloseMenu()
				local ped = PlayerPedId()
				if IsPedInAnyBoat(ped) then
					boat = GetVehiclePedIsIn(ped, true)
					if not isAnchored then
						SetBoatAnchor(boat, true)
						SetBoatFrozenWhenAnchored(boat, true)
						isAnchored = true
					else
						SetBoatAnchor(boat, false)
						isAnchored = false
					end
				end
            elseif WarMenu.Button("Exit") then
                WarMenu.CloseMenu()
                Wait(600)
                WarMenu.Display()
            end
        end

    end
end)

-- | Spawn boat | --
RegisterNetEvent('dag_boatrental:client:spawnBoat' )
AddEventHandler('dag_boatrental:client:spawnBoat', function(_model)

	DeleteVehicle(spawn_boat)
	RequestModel(_model)

	while not HasModelLoaded(_model) do
		Wait(500)
	end

	zone_name = GetCurrentTownName()

	spawn_boat = CreateVehicle(_model, Config.BoatSpawn[zone_name].x, Config.BoatSpawn[zone_name].y, Config.BoatSpawn[zone_name].z, Config.BoatSpawn[zone_name].h, true, false)
	SetVehicleOnGroundProperly(spawn_boat)
	SetModelAsNoLongerNeeded(_model)

	-- local player = PlayerPedId()
	-- DoScreenFadeOut(500)
	-- Wait(500)
	-- SetPedIntoVehicle(player, spawn_boat, -1)
	-- Wait(500)
	-- DoScreenFadeIn(500)
	boating = true
end)