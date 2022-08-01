ESX = nil
local stations = {73774428}

Citizen.CreateThread(function()
	while ESX == nil do
	    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	    Citizen.Wait(0)
	end
end)

local textshowed = false
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped)

		for i = 1, #stations do
			local zone = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, stations[i], false, false, false)
			local cigStore = GetEntityCoords(zone)
			local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, cigStore.x, cigStore.y, cigStore.z, true)

			if dist < 1.8 then
				local loc = vector3(cigStore.x, cigStore.y, cigStore.z + 1.0)     
				if Config.okokTextUI then
					if not textshowed then
						exports['okokTextUI']:Open(_U('info_textui'), Config.okokTextUIcolor, Config.okokTextUIposition)
						textshowed = true
					end
				else
					ESX.ShowHelpNotification(_U('helpnotify'))
				end
				if IsControlJustReleased(0, 38) then
					OpenShopMenu()
					if textshowed then
						exports['okokTextUI']:Close()
					end
				end
			else
				Citizen.Wait(1500)
				exports['okokTextUI']:Close()
				textshowed = false
			end
		end
	end
end)

function OpenShopMenu(zone)
	local elements = {}
	for i=1, #Config.Items, 1 do
		local item = Config.Items[i]

		table.insert(elements, {
			label      = item.label .. " " .. _U('price') .. " " .. Config.Currency .. item.price,
			name       = item.name,
			price      = item.price,

			value      = 1,
			type       = 'slider',
			min        = 1,
			max        = 100
		})
	end

	ESX.UI.Menu.CloseAll()

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
				title    = _U('shopname'),
				align    = 'left',
				elements = elements
			}, function(data, menu)
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
					title    = _U('buy'),
					align    = 'left',
					elements = {
						{label = _U('no'),  value = 'no'},
						{label = _U('yes'), value = 'yes'}
				}}, function(data2, menu2)
					if data2.current.value == 'yes' then
						local price = (data.current.price * data.current.value)
						TriggerServerEvent('kushc0de:buyCig', data.current.name, data.current.value, price)
						ESX.UI.Menu.CloseAll()
					else
						ESX.UI.Menu.CloseAll()
					end

					menu2.close()
				end, function(data2, menu2)
					menu2.close()
				end)
			end, function(data, menu)
				menu.close()

				currentAction     = 'shop_menu'
				currentActionMsg  = _U('press_menu')
				currentActionData = {zone = zone}
			end)
end