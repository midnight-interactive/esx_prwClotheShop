ESX                  = nil
_menuPool = NativeUI.CreatePool()
_menuPool:RefreshIndex()
local MaskTab  = {}
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
RegisterNetEvent('parow:SyncAccess')
AddEventHandler('parow:SyncAccess', function()
    ESX.TriggerServerCallback("parow:getMask", function(result)
        MaskTab = result
    end)
end)
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction6           = nil
local CurrentAction6Msg        = ''
local CurrentAction6Data       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil
local MenuOn = false
local curSex = 0
function ClotheShopAdd(menu)

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _)
		curSex = skin.sex
		--TriggerEvent('skinchanger:loadSkin', skin)
	end)
	playerPed = GetPlayerPed(-1)
	local tenues = NativeUI.CreateItem("Mes tenues","")
	menu:AddItem(tenues)
	local haut = _menuPool:AddSubMenu(menu, "Top","",true,true)
	local bras = _menuPool:AddSubMenu(menu, "Bras","",true,true)
	local tsh = _menuPool:AddSubMenu(menu, "T-shirt","",true,true)
	local bas = _menuPool:AddSubMenu(menu, "Pants","",true,true)
	local chaussure = _menuPool:AddSubMenu(menu, "Shoes","",true,true)
	local lunette = _menuPool:AddSubMenu(menu, "Glasses","",true,true)
	local chapeau = _menuPool:AddSubMenu(menu, "Hat","",true,true)
	local gil = _menuPool:AddSubMenu(menu, "Bulletproof Vest","",true,true)
	local sac = _menuPool:AddSubMenu(menu, "Backpack","",true,true)
	--local montre = _menuPool:AddSubMenu(menu, "Montre","",true,true)
	local chain = _menuPool:AddSubMenu(menu, "Chain","",true,true)
	local boucle = _menuPool:AddSubMenu(menu, "Earring","",true,true)

 	chaussureFct(chaussure)
 	gilFct(gil)
 	basFct(bas)
 	casqueFct(chapeau)
	torsomenu(bras)
	tshirtmenu(tsh)
 	lunetteFct(lunette)
	--montreMenu(montre)
 	sacFct(sac)
 	boucleFct(boucle)
 	hautFct(haut)
	chainFct(chain)
	 
	menu.OnItemSelect = function(_,_,ind)
		if ind == 1 then
			_menuPool:CloseAllMenus()
			local clotheShop2 = NativeUI.CreateMenu("", "Shop", 5, 100,"shopui_title_midfashion","shopui_title_midfashion")
			_menuPool:Add(clotheShop2)
			SavedTenues(clotheShop2)
			clotheShop2:Visible(not clotheShop2:Visible())
		end

	end

	menu.OnMenuClosed = function(_, _, _)

		RecupTenues()
		MenuOn = false
		
	end

end
function refreshthisshit()
	_menuPool:CloseAllMenus(

	)
	local clotheShop2 = NativeUI.CreateMenu("", "Shop", 5, 100,"shopui_title_midfashion","shopui_title_midfashion")
	_menuPool:Add(clotheShop2)
	SavedTenues(clotheShop2)
	clotheShop2:Visible(not clotheShop2:Visible())
end
function SavedTenues(menu)
	p = NativeUI.CreateItem("Save this outfit","")
	menu:AddItem(p)
	local sqk = nil
	menu.OnItemSelect = function(_,ix,ind)
		sqk = ind - 1
		if ind == 1 then
			k = gettxt2("Tenue")
			if k ~= nil then
				if tostring(k) ~= nil and tostring(k) ~= "" then

					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerServerEvent("parow:SaveTenueS",k,skin)
					end)
					Wait(550)
					refreshthisshit()
				end
			end
		end
	end
	ESX.TriggerServerCallback('parow:GetTenues', function(skin)
		if #skin == 0 then
			menu:AddItem(NativeUI.CreateItem("Empty",""))
		end
		for i = 1, #skin,1 do
			local m = _menuPool:AddSubMenu(menu, skin[i].label,"",true,true)
			p = NativeUI.CreateItem("Equip","")
			k = NativeUI.CreateItem("Rename","")
			l = NativeUI.CreateItem("Remove","")
			m:AddItem(p)
			m:AddItem(k)
			m:AddItem(l)
			

			m.OnItemSelect = function(_,ix,v)
				clothes = skin[i]

				for k,v in pairs(clothes) do
					if k == "tenue" then
					clothes = v
					break
					end
				end
				if v == 1 then

					TriggerEvent('skinchanger:getSkin', function(skin)

					TriggerEvent('skinchanger:loadClothes', skin, json.decode(clothes))
					TriggerEvent('esx_skin:setLastSkin', skin)
  
					TriggerEvent('skinchanger:getSkin', function(skin)
					  TriggerServerEvent('esx_skin:save', skin)
					end)
					_menuPool:CloseAllMenus()
				end)
				end
				if v == 2 then
					kx = gettxt2(skin[i].label)
					if tostring(kx) ~= nil then
						TriggerServerEvent('parow:RenameTenue', skin[i].id,kx)
						Wait(550)
						refreshthisshit()
					end
				end
				if v == 3 then
					TriggerServerEvent('parow:DeleteTenue', skin[i].id)
					Wait(550)
					refreshthisshit()
				end
			end
		end
		_menuPool:RefreshIndex()
	end)

end

function gettxt2(txtt)
    AddTextEntry('FMMC_MPM_NA', "Texte")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", txtt, "", "", "", 100)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
		local result = GetOnscreenKeyboardResult()
		if tonumber(result) ~= nil then
			if tonumber(result) >= 1 then

				return tonumber(result)
			else
				
			end
		else
		return result
		end
    end

end
function montreMenu(menu)

	for i = -1,19,1 do
		--
		chapeauItem = {}
		local amount = {}
		local ind = i+2
		for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 6, i+1), 1 do

			amount[c] = c 
			
		end

		v = NativeUI.CreateListItem("Watch #"..ind, amount, 1, "",5)
	
		menu:AddItem(v)
		

	end
	--chapeauItem= {}
	_menuPool:RefreshIndex()
	
	menu.OnIndexChange = function(menu,index6)
		local index2 = 1
		
		playerPed = GetPlayerPed(-1)
		SetPedPropIndex(playerPed, 6, index6-1, 0, 2)
		menu.OnListSelect = function(_, _, _)
			ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
				if result then
			
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
				clothesSkin = {

				   ['montre'] = index6-1,
				   ['montre2'] = index2-1,
				   


			   }
			   TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			   
		   
		   
	   end)

	   TriggerEvent('skinchanger:getSkin', function(skin)

		   
		   TriggerServerEvent('esx_skin:save', skin)
		   
	   
	   
	   end)
	end
	end)

		end
		menu.OnListChange = function(_, _, index26)
			index2 = index26
			SetPedPropIndex(playerPed, 6, index6-1, index26-1, 2)
		end
	end

end

function RecupTenues()
    --("ou")

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _)
--		curSex = skin.sex
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

end
function chainFct(menu)



	for i = -1,GetNumberOfPedDrawableVariations(playerPed,7),1 do
		--
		chapeauItem = {}
		local amount = {}
		local ind = i+2
		for c = 1, GetNumberOfPedTextureVariations(playerPed, 7, i+1), 1 do

			amount[c] = c 
			
		end

		v = NativeUI.CreateListItem("Chain #"..ind, amount, 1, "",5)
	
		menu:AddItem(v)
		

	end
	--chapeauItem= {}
	_menuPool:RefreshIndex()
	
	menu.OnIndexChange = function(menu,index6)
		local index2 = 1
		
		playerPed = GetPlayerPed(-1)
		SetPedComponentVariation(playerPed,7, index6-1, 0, 2)
		menu.OnListSelect = function(_, _, _)
			ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
				if result then
			
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
				clothesSkin = {

				   ['chain_1'] = index6-1,
				   ['chain_2'] = index2-1,
				   


			   }
			   TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			   
		   
		   
	   end)

	   TriggerEvent('skinchanger:getSkin', function(skin)

		   
		   TriggerServerEvent('esx_skin:save', skin)
		   
	   
	   
	   end)
	end
	end)

		end
		menu.OnListChange = function(_, _, index26)
			index2 = index26
			SetPedComponentVariation(playerPed, 7, index6-1, index26-1, 2)
		end
	end

end

function torsomenu(menu)

	for i = 0,GetNumberOfPedDrawableVariations(playerPed,8)-1,1 do
		--		Citizen.Wait(2)
				local amount = {}
				local ind = i+1
				for c = 1, GetNumberOfPedTextureVariations(playerPed, 8, i), 1 do
		
					amount[c] = c 
					
				end

				x = NativeUI.CreateItem("Bras #"..i,"")
			
				menu:AddItem(x)
				
		
	end
		
	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)

		local index2 = 1

		
--		SetPedComponentVariation(playerPed,3, brasInd[index6], 0, 2)
--		SetPedComponentVariation(playerPed,8, sousTorse[index6], 0, 2)

		SetPedComponentVariation(playerPed,3, index6-1, 0, 2)
		menu.OnItemSelect = function(menu, _, _)
			
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
					 clothesSkin = {

						['arms'] = index6-1


					}
					print(json.encode(skin))
					print(json.encode(clothesSkin))
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					
				
				
			end)

			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
				TriggerServerEvent('esx_skin:save', skin)
				
			
			
			end)
			menu.OnMenuClosed = function(_)
				gilItem= {}
				sousTorse = {}
			end
		end

	end



end
function tshirtmenu(menu)

	for i = 0,GetNumberOfPedDrawableVariations(playerPed,8)-1,1 do
		--		Citizen.Wait(2)
				local amount = {}
				local ind = i+1
				for c = 1, GetNumberOfPedTextureVariations(playerPed, 8, i), 1 do
		
					amount[c] = c 
					
				end

				x = NativeUI.CreateListItem("Under top #"..i, amount, 1, "",5)
			
				menu:AddItem(x)
				
		
	end
		
	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)

		local index2 = 1

		
--		SetPedComponentVariation(playerPed,3, brasInd[index6], 0, 2)
--		SetPedComponentVariation(playerPed,8, sousTorse[index6], 0, 2)

		SetPedComponentVariation(playerPed,8, index6-1, 0, 2)
		menu.OnListSelect = function(menu, _, _)
			ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
				if result then
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
					 clothesSkin = {

						['tshirt_1'] =index6-1, ['tshirt_2'] = index2-1,


					}
					print(json.encode(skin))
					print(json.encode(clothesSkin))
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					
				
				
			end)

			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
				TriggerServerEvent('esx_skin:save', skin)
				
			
			
			end)
		end
		end)
			menu.OnMenuClosed = function(_)
				gilItem= {}
				sousTorse = {}
			end
		end
		menu.OnListChange = function(_, _, index24)
			index2 = index24
			SetPedComponentVariation(playerPed,8, index6-1, index24-1, 2)

			

		end
	end

end

function hautFct(menu)



	playerPed = GetPlayerPed(-1)

	 if curSex == 0 then
		--hautItems = {"T-shirt","T-shirt","Maillot de basket","Survêtement","Veste","Débardeur","Veste en cuir","Veste capuche","Sweat","Polo","Costard","Chemise","Chemise","Chemise","Chemise à carreaux","Torse nu","T-shirt","Débardeur","T-shirt noël","Veste classe","Veste classe","s"}
		sousTorse = {15,15,15,1,1,15,2,1,15,15,10,6 ,15,15,15,15,15,15,15,6,4,13,7,15,1,4,6,15,4,4,31,31,31,31,15,15,4 ,15,2,15,15,6,15,15,15,15,6,0}
		brasInd =   {0 ,0 ,2 ,0,1,5 ,1,1,8 ,0 ,1 ,11,6 ,11 ,1  ,15 ,0 ,5 ,0,1,1,11,0,1,1,11,11,1,1,1,1,1,1,0,0,1		,5 ,1,8 ,0 ,0,1 ,11,11,0, 0,1}
	hautItems = {"T-shirt","T-shirt","Basketball jersey","Tracksuit Jacket","Classic Jacket","Tank Top","Leather Jacket","Hoodie","Sweatshirt","Polo","Suit Jacket","Class","Long Shirt","Shirt","Checkered Shirt","Nothing","T-shirt","Tank top","T-shirt","Suit jacket","Suit jacket","Jacket","T-shirt","Suit Jacket","Suit Jacket","Jacket","Shirt","Suit jacket","Suit jacket","Suit jacket","Suit jacket","Suit jacket","Suit jacket","T-shirt","T-shirt","Suit jacket","Tank top","Leather jacket","Sweatshirt","Polo","Jacket","Shirt","Shirt with suspenders","Shirt with suspender","T-shirt","Shirt","Suit jacket","T-shirt","High aviation","Sweater","Sweater","Christmas Sweater","Christmas Sweater","Sweater","Aviation jacket","High police","Dirty t-shirt","Jacket","Suit jacket","Suit jacket","Suit jacket","Gillet","Jacket","Shirt","Leather jacket","Weird jacket","Weird jacket","Latex top","","Jacket","Jacket with fur","T-shirt","Long jacket","T-shirt","Luxury jacket","Luxury jacket","Long jacket","Long jacket","Luxury sweater","College jacket","Long T-shirt","Long T-shirt","Long Polo","Long T-shirt","Street sweater","Jacket","Hoodie","College jacket","College jacket","","Gillet","Nothing","Jacket","Polo","Polo","Shirt","Hoodie","T-shirt","High commando","Suit jacket","VSuit jacket","Suit jacket","Suit jacket","Suit jacket","Suit jacket","Tourist shirt","Luxury jacket","Asian jacket","Luxury jacket","Strange tank top","Leather jacket","Turtleneck sweater","Long jacket","Jacket","Karate outfit","Long jacket","Senior santa claus","Shirt","Jacket","Suit jacket","Jacket","Strange top","","Polo","Fisherman's jacket","Jacket","Checked jacket","Checked jacket","Long T-shirt","Safety jacket","","","","Chill shirt","Hoodie","Luxury jacket","Jacket","Old sweater","Jacket","Turtleneck sweater","Long jacket","Jacket","Long jacket","Jacket","Pyjamas","Pyjamas","T-shirt","Aviation jacket","Aviation jacket","Cowboy jacket","Asian jacket","Leather jacket","Sports top","Jacket","Jacket","Cowboy Jacket","Leather jacket","Jacket","Jacket","Jacket","","Leather jacket","Jacket","T-shirt","Special top","Jacket","Puffy jacket","Jacket","Jean Jacket","Jean Jacket","Hoodie","Jean Jacket","Jean Jacket","Leather jacket","Leather jacket","Jacket","","High tron","Jacket","Jacket","Jacket","Sweatshirt","Suit jacket","Long jacket","Long open jacket","Special gillet","Long Jacket","Long Jacket","Long open jacket","Patterned sweater","Jacket","Long jacket","T-shirt","Christmas sweater","Christmas sweater","Christmas sweater","Christmas sweater","Christmas Jacket","Christmas Jacket","Hoodie","Luminous T-shirt","Hoodie","Hoodie","Long hooded jacket","Hoodie","Camo Jacket","Hooded Camo Jacket","T-shirt","Long jacket","Long jacket","Hooded Long jacket","","","Camo Jacket","Camo Jacket","Camo Jacket","Long Jacket","Long hooded jacket","Camo Jacket","Camouflage top","Camouflage top","Camo T-shirt","Short sleeve jacket","Jacket","Long sleeve t-shirt","T-shirt","Aviation jacket","Aviation jacket","Jacket","Jacket","Aviation jacket","Polo","Polo","Tank top","Very short sleeve t-shirt","Camo Tank Top","Fur jacket","Polo","Polo","Jacket","Jacket","Winter sweater","Super hero sweater","Short sleeve jacket","Jacket","Jacket","Polo","Jacket","Nothing","Jacket with hood","High pilot","Original sweater","Original jacket","Old school jacket","Diamond jacket","Special sweater","Special T-shirt","Special open jacket","Hoodie","Hoodie","Leather jacket","Checked jacket","Checked jacket","Jacket","Jacket","Puffy jacket","High pilot","T-shirt"}

	for i = 0,GetNumberOfPedDrawableVariations(playerPed,11)-1,1 do
--		Citizen.Wait(2)
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedTextureVariations(playerPed, 11, i), 1 do

			amount[c] = c 
			
		end
		if hautItems[ind] == nil then
			hautItems[ind] = "Top #"..i
		end
		x = NativeUI.CreateListItem(hautItems[ind], amount, 1, "",5)
	
		menu:AddItem(x)
		

	end




	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)

		local index2 = 1

		if brasInd[index6] == nil then
			brasInd[index6] = 1

		end
		if sousTorse[index6] == nil then
			sousTorse[index6] = 1

		end
		
--		SetPedComponentVariation(playerPed,3, brasInd[index6], 0, 2)
--		SetPedComponentVariation(playerPed,8, sousTorse[index6], 0, 2)

		SetPedComponentVariation(playerPed,11, index6-1, 0, 2)
		menu.OnListSelect = function(menu, _, _)
			ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
				if result then
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
					 clothesSkin = {
						['torso_1'] = index6-1, ['torso_2'] = index2-1,


					}
					print(json.encode(skin))
					print(json.encode(clothesSkin))
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					
				
				
			end)

			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
				TriggerServerEvent('esx_skin:save', skin)
				
			
			
			end)
		end
	end)
			menu.OnMenuClosed = function(_)
				gilItem= {}
				sousTorse = {}
			end
		end
		menu.OnListChange = function(_, _, index24)
			index2 = index24
			SetPedComponentVariation(playerPed,11, index6-1, index24-1, 2)

			

		end
	end
	gilItem={}
	_menuPool:RefreshIndex()
	
else
	
end
hautItems = {}
gilItem= {}
sousTorse = {}
end





function sacFct(menu)
	playerPed = GetPlayerPed(-1)
	n = NativeUI.CreateItem("Tactical bag","")
	menu:AddItem(n)
	c = NativeUI.CreateItem("Black bag","")
	menu:AddItem(c)
	cx = NativeUI.CreateItem("No bag","")
	menu:AddItem(cx)
	menu.OnItemSelect = function (_, _, index)
		if index == 1 then
			SetPedComponentVariation(playerPed, 5, 40, 0, 2)
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
				clothesSkin = {
				   ['bags_1'] = 40, ['torso_2'] = 0,


			   }

			   TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			   
		   
		   
	   end)

	   TriggerEvent('skinchanger:getSkin', function(skin)

		   
		   TriggerServerEvent('esx_skin:save', skin)
		   
	   
	   
	   end)
	elseif index == 2 then
			SetPedComponentVariation(playerPed, 5, 44, 0, 2)
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
				clothesSkin = {
				   ['bags_1'] = 44, ['torso_2'] = 0,


				}
			   TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			   
		   
		   
	   end)

	   TriggerEvent('skinchanger:getSkin', function(skin)

		   
		   TriggerServerEvent('esx_skin:save', skin)
		   
	   
	   
	   end)
	else

		SetPedComponentVariation(playerPed, 5, 0, 0, 2)
		TriggerEvent('skinchanger:getSkin', function(skin)

			

			clothesSkin = {
			   ['bags_1'] = 0, ['torso_2'] = 0,


			}
		   TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		   
	   
	   
   end)

   TriggerEvent('skinchanger:getSkin', function(skin)

	   
	   TriggerServerEvent('esx_skin:save', skin)
	   
   
   
   end)
		end

	end


end



function gilFct(menu)


	playerPed = GetPlayerPed(-1)

	 if curSex == 0 then

		gilItem = {
			"None","Lightweight gillet","Medium Gillet","Gillet","Heavy Gillet","Gillet","Large Gillet","Gillet large","/","/","Gillet large","Gillet large","Gillet large","Aucun","Aucun","Gillet lourd","Gillet très lourd","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré","Gillet coloré"

		}

	

	for i = 0,GetNumberOfPedDrawableVariations(playerPed,9)-1,1 do
		--
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedTextureVariations(playerPed, 9, i), 1 do

			amount[c] = c 
			
		end
		if gilItem[ind] == nil then
			gilItem[ind] =  "Gillet #"..i
		end
		x = NativeUI.CreateListItem(gilItem[ind], amount, 1, "",5)
	
		menu:AddItem(x)
		

	end

else
	
end
_menuPool:RefreshIndex()

	
	menu.OnIndexChange = function(menu,index)
		playerPed = GetPlayerPed(-1)
		SetPedComponentVariation(playerPed, 9, index-1, 0, 2)
		menu.OnListChange = function(menu, _, index2)
			SetPedComponentVariation(playerPed, 9, index-1, index2-1, 2)
			
			menu.OnListSelect = function(menu, _, _)
				TriggerEvent('skinchanger:getSkin', function(skin)
					TriggerServerEvent('esx_skin:save', skin)
				end)
				menu.OnMenuClosed = function(_)
					gilItem= {}
				end
			end
		end
	end
	gilItem={}
end


function basFct(menu)
	playerPed = GetPlayerPed(-1)

	 if curSex == 0 then

		botItem = {
			"Jeans",
			"Jeans",
			"Shorts",
			"Tracksuit",
			"Jeans",
			"Wide suit",
			"Shorts",
			"Jeans",
			"Chinos",
			"Chinos with belt",
			"Black jeans",
			"/",
			"Shorts","Black jeans with belt","Underpants","Shorts","Colorful shorts","Chino shorts","Underpants","Belt pants","Trousers","Underpants","Chinos","Chinos with belt","Black jeans","Black jeans","Pattern jeans","Colored pants","Black Jeans","Special pants","Aviator pants","Running pants","Legging","Large pants","Operation pants","Classy pants","Worker's pants","Classy pants","Papel pants","Papel pants","Running suit","Aviator pants","Long Shorts","Large Jeans","/","Tracksuit","Combat pants","Determined pants","	","Classy pants","Classy pants","Luxury pants","Luxury Pants","Luxury Pants","Pattern shorts", "Tracksuit","Skirt","Christmas pants","Special pants","Pixie pants","Patterned trousers","Underpants","Long Shorts","Jeans","Tracksuit","Pyjamas","Chill pants","Parachute pants","Western pants","Pants of death","Cowboy pants","Skinny pants","Skinny pants","Skinny pants","Skinny pants","Jeans","Jeans","Tron pants","Tracksuit","Leather trousers","Petite Pants","Petite Pants","Jeans","Latex pants","Special Operation Pants","Luminous pants"


		}

	

	for i = 0,GetNumberOfPedDrawableVariations(playerPed,4)-1,1 do
		--
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedTextureVariations(playerPed, 4, i), 1 do

			amount[c] = c 
			
		end
		if botItem[ind] == nil then
			botItem[ind] = "Pantalon #"..i
		end
		x = NativeUI.CreateListItem(botItem[ind], amount, 1, "",5)
	
		menu:AddItem(x)
		

	end

else
		botItem = {"Jeans","Wide Jeans","Jogging shorts","Simple Pants","Hemmed Jeans","Shorts","Elephant patterned trousers","Work Skirt","Short skirt","Short sequined skirt","Shorts","Denim Jeans","Schoolgirl skirt","I am the 13","Shorts 1","Panties 1","Shorts 2","Cheeky 2","Long skirt","Shorty","Jartelle door","Cheeky","Jartelle door","Elephant patterned trousers","Long skirt","Shorts","Short skirt","Slim","Skirt","Aviator pants","Treillis","Mercenary pants","Large pants","Garbage Trousers","Long skirt","Suit pants","Work pants","Work Pants 2","Simple pants","Pants Suit","Aviator pants","Pants Closure","Leggings with hole","Work Pants","BUUUG","Suit pants","Mercenary pants","Work Pants","Elephant placket pants","Slim","Elephant placket pants 1","Elephant placket pants 2","Slim 1","Slim 2","Cheeky","Open Skirt","Jogging","Christmas pants","Christmas elephant trousers","Treillis","Shorty","Jartel door","High waist pants","Jogging","Pyjamas","Biker pants","Biker pants 2","Western pants","Competition pants","Simple Pants","Western pants 2","Slim Jeans","Slim Jeans 2","Slim 1","Slim 2","Slim 3","Fishnet tights","Biker pants","Jogging 1","Jogging 2","Jogging 3","Jogging 4","Jogging 5","jogging 6","Disguise","Military Leggings","Illuminated Leggings","Military Pants","Military pants tucked in","Military Shorts","Wide military pants","Wide Jeans","Competition Biker","Aviator pants 1","Aviator pants 2","Leggings","Colored leggings","Work pants","Tucked-in suit","Tracksuit","Leggings","Large pants"}



	for i = 0,GetNumberOfPedDrawableVariations(playerPed,4)-1,1 do
		--
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedTextureVariations(playerPed, 4, i), 1 do

			amount[c] = c 
			
		end
		if botItem[ind] == nil then
			botItem[ind] = "Pantalon #"..i
		end
		x = NativeUI.CreateListItem(botItem[ind], amount, 1, "",5)

		menu:AddItem(x)
		

	end
end
_menuPool:RefreshIndex()


	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)
		SetPedComponentVariation(playerPed, 4, index6-1, 0, 2)
		local index2 = 1
		menu.OnListSelect = function(menu, _, _)
			ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
				if result then
			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
					 clothesSkin = {
						['pants_1'] = index6-1, ['pants_2'] = index2-1,


					}

					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					
				
				
			end)

			TriggerEvent('skinchanger:getSkin', function(skin)
	
				
				TriggerServerEvent('esx_skin:save', skin)
				
			
			
			end)
		end
	end)
			menu.OnMenuClosed = function(_)
				gilItem= {}
				sousTorse = {}
			end
		end
		menu.OnListChange = function(_, _, index24)
			index2 = index24
			SetPedComponentVariation(playerPed, 4, index6-1, index24-1, 2)

		end
	end
	botItem={}
end



function chaussureFct(menu)
	--("s")
	playerPed = GetPlayerPed(-1)

	 if curSex == 0 then

						chaussureItem = {
							"Sneakers",
							"Low top shoe",
							"Sneakers",
							"Luxurious shoe",
							"Classic shoe",
							"Tap Shoe",
							"Sock flapper",
							"High sock shoe",
							"High sock shoe",
							"High sock shoe",
							"Luxury high sock shoe",
							"Luxury shoe",
							"Adventurer shoe",
							"/",
							"Adventurer shoe",
							"Luxury shoe",
							"Tap shoe",
							"Leprechaun shoe",
							"Luxury shoe",
							"Luxury shoe",
							"Luxury shoe",
							"Luxury shoe",
							"Classic shoe",
							"Ankle boot",
							"Ankle boot",
							"Ankle boot",
							"Chaussure classique",
							"Ankle boot",
							"Extravagant shoe",
							"Luxury shoe",
							"Luxury shoe",
							"Sneakers",
							"Street shoe",
							"/",
							"Barefoot",
							"Ankle boot",
							"Luxury shoe",
							"Boot",
							"Shoe with heel",
							"Boot",
							"Luxury shoe",
							"Slipper",
							"Simple Sneakers",
							"Shoe class",
							"Boot",
							"Low shoe",
							"Sneakers",
							"Boot",
							"Classic shoe",
							
							"Classic shoe",
							
							"Boot",
							"Walking shoe",
							"Shoe",
							"Boot",
							"Walking shoe",
							"Walking shoe",
							"Walking shoe",
							"Walking shoe",
							"Tron shoe",
							"Shoe",
							"Sneakers",
							"Luminous slipper"

						}

						for i = 0,GetNumberOfPedDrawableVariations(playerPed,6)-1,1 do
							--
							local amount = {}
							local ind = i+1
							for c = 1, GetNumberOfPedTextureVariations(playerPed, 6, i), 1 do

								amount[c] = c 
								
							end
							if chaussureItem[ind] == nil then
								chaussureItem[ind] = "Shoes #"..i
							end
							x = NativeUI.CreateListItem(chaussureItem[ind], amount, 1, "",5)
						
							menu:AddItem(x)
							

						end

					_menuPool:RefreshIndex()

						
						menu.OnIndexChange = function(menu,index6)
							playerPed = GetPlayerPed(-1)
							SetPedComponentVariation(playerPed, 6, index6-1, 0, 2)
							local index2 = 1
							menu.OnListSelect = function(menu, _, index)
								print(index)
								ESX.TriggerServerCallback("parow:GetMoneyVet", function(result)
										if result then
												TriggerEvent('skinchanger:getSkin', function(skin)
										
													
										
														clothesSkin = {
															['shoes_1'] = index6-1, ['shoes_2'] = index2-1,


														}

														TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
														
													
													
												end)

												TriggerEvent('skinchanger:getSkin', function(skin)
										
													
													TriggerServerEvent('esx_skin:save', skin)
													
												
												
												end)
											
											
										end	
									 				
										menu.OnMenuClosed = function(_)
											gilItem= {}
											sousTorse = {}
										end
								end)
							end
							
							menu.OnListChange = function(menu, _, index23)
							index2 = index23
								SetPedComponentVariation(playerPed, 6, index6-1, index23-1, 2)

									menu.OnMenuClosed = function(_)
										chaussureItem= {}
									end
								
							end
						end
	else
		chaussureItem= {"Heel","Street shoe","Boots","Converse","Sports shoe","Flip flops","Pointed Toe Stiletto Heel","Ankle boots","Open toe heel","Shorts","Sports shoe","Basketball Rising Shoe","Barefoot","Ballerina","Heel Sandal","Sandal","Leprechaun shoe","Pump","Heeled shoe","Stiletto heel","Boot","Stiletto heel 2","Pump","Safety boot","Safety boot 2","Us boots","Street shoe","Sports shoe","Costume shoe","Ankle boot","High Shoe","Basketball shoe","Converse","Barefoot","Barefoot 2","Mountain boot","Moccasin","Western Boot","Cowboy boot","Costume boot","Pump","Heel 2","Heeled ankle boot","stiletto heel 2","Western boot 2","Western shoe","Sports shoe","Ski boot","Converse 2","Converse 3","Biker Boot","Biker shoe","Leather ankle boot","Biker Boot 2","Biker shoe 2","Biker shoe 3","Biker shoe 3","Illuminated sports shoe","Leather shoe","Basketball Rising","Slipper","Safety shoe","Mountain boot","Mountain shoe","Mountain boot 2","Mountain shoe 2","Tennis shoes","High Shoe","Street shoe","Webbed","Slipper","Basketball Shoe","Boot","Safety shoe","Mountain boot","Walking shoe","Big Heel"}
		for i = 0,#chaussureItem,1 do
			--
			local amount = {}
			local ind = i+1
			for c = 1, GetNumberOfPedTextureVariations(playerPed, 6, i), 1 do
	
				amount[c] = c 
				
			end
			if chaussureItem[ind] == nil then
				chaussureItem[ind] = "Shoes #"..i
			end
			x = NativeUI.CreateListItem(chaussureItem[ind], amount, 1, "",5)
		
			menu:AddItem(x)
			
	
		end
	end
end


function boucleFct(menu)
	--("s")
	if curSex == 0 or 1 then
	playerPed = GetPlayerPed(-1)
	boucleItem = {
		"Headset",
		"Headset",
		"Headset",
		"None",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",
		"Earring",

		"Earring",



	}
	for i = 0,36,1 do
		--
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 2, i), 1 do

			amount[c] = c 
			
		end
		if boucleItem[i] == nil then
			boucleItem[i] = "Earpiece #"..i
		end
		x = NativeUI.CreateListItem(boucleItem[ind], amount, 1, "",5)
	
		menu:AddItem(x)
		

	end
	--boucleItem= {}
	_menuPool:RefreshIndex()
	local index2 = 1
	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)
		SetPedPropIndex(playerPed, 2, index6-1, 0, 2)
		index2 = 1
		menu.OnListSelect = function(_, _, _)
			TriggerServerEvent("parow:SetNewMasque",index6-1,index2-1,"Boucle",boucleItem[index6],2)
		end
		menu.OnListChange = function(_, _, index26)
			index2 = index26
			SetPedPropIndex(playerPed, 2, index6-1, index26-1, 2)

		end
	end
end

end


function lunetteFct(menu)
	--("s")
	if curSex == 0 then
	playerPed = GetPlayerPed(-1)
	lunetteItem = {
		"Any",
		"Sport glasses",
		"Sunglasses",
		"Old school glasses",
		"Middle age glasses",
		"Sunglasses",
		"Any",
		"Sunglasses",
		"Glasses",
		"Sport Glasses",
		"Mafia glasses",
		"Any",
		"Luxury frames",
		"Baron's scope",
		"Any",
		"Sport Glasses",
		"Sport Glasses",
		"Tinted frames",
		"Glasses",
		"Fake frames",
		"Modern frames",
		"American Glasses",
		"American Glasses",
		"Sport glasses",
		
		"Aviator glasses",
		"Aviator glasses"
	}


	for i = 0,25,1 do
		--
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 1, i), 1 do

			amount[c] = c 
			
		end
		if lunetteItem[i] == nil then
			lunetteItem[i] = "Glasses #"..i
		end
		x = NativeUI.CreateListItem(lunetteItem[ind], amount, 1, "",5)
	
		menu:AddItem(x)
		

	end
	_menuPool:RefreshIndex()
--	lunetteItem= {}
	local index2 = 1
	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)
		print(index2)
		index2 = 1
		SetPedPropIndex(playerPed, 1, index6-1, 0, 2)
		
		menu.OnListSelect = function(_, _, _)
			print(index2)
			TriggerServerEvent("parow:SetNewMasque",index6-1,index2-1,"Lunette",lunetteItem[index6],1)


		end
		menu.OnListChange = function(menu, _, index24)
			print(index2)
			
			index2 = index24
			print(index2)

			SetPedPropIndex(playerPed, 1, index6-1, index24-1, 2)
			

				menu.OnMenuClosed = function(_)
					
				end
			
		end
		
	end
end

end
Citizen.CreateThread(function()

    for i = 1, #ConfigclotheShop.Map, 1 do
        local blip = AddBlipForCoord(ConfigclotheShop.Map[i].x, ConfigclotheShop.Map[i].y, ConfigclotheShop.Map[i].z)
        SetBlipSprite(blip, ConfigclotheShop.Map[i].id)
        SetBlipDisplay(blip, 4)
        SetBlipColour(blip, ConfigclotheShop.Map[i].color)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 1.0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(ConfigclotheShop.Map[i].name)
        EndTextCommandSetBlipName(blip)
    end

end)
function casqueFct(menu)
	if curSex == 0 then
playerPed = GetPlayerPed(-1)
	
	
	local chapeauItem = {
		"Helmet",
		"dunce cap",
		"Bonnet",
		"Bob",
		"LS cap",
		"Bonnet",
		"Military cap",
		"Beret",
		"",
		"Cap inside out",
		"Cap",
		"",
		"Hat",
		"Cowboy Hat",
		"Bandana",
		"Headphone",
		"Helmet",
		"Helmet",
		"Helmet",
		"Pilot helmet",
		"Fisherman's bob",
		"Chill hat",
		"Christmas hat",
		"Leprechaun hat",
		"Christmas horn",
		"Hat",
		"Bowler hat",
		"High hat",
		"Bonnet",
		"Hat",
		"Hat",
		"USA Hat",
		"USA Hat",
		"USA Hat",
		"USA Bonnet",
		"USA",
		"USA Antenna",
		"Beer helmet",
		"Aviation helmet",
		"Intervention helmet",
		"Christmas hat",
		"Christmas hat",
		"Christmas hat",
		"Christmas hat",
		"Cap",
		"Cap inside out",
		"LSPD Cap",
		"Aviator helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Helmet",
		"Cap",
		"Cap",
		"Cap",
		"Alien Hat",
		"Cap",
		"Helmet",
		"Cap",
		"Hat",
		"Helmet",
		"Hat",
		"Cap"
		
	}




	for i = -1,GetNumberOfPedDrawableVariations(playerPed, 0),1 do
		--
		local amount = {}
		local ind = i+2
		for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 0, i+1), 1 do

			amount[c] = c 
			
		end
		if chapeauItem[i] == nil then
			chapeauItem[i] = i
		end
		v = NativeUI.CreateListItem(chapeauItem[ind], amount, 1, "",5)
	
		menu:AddItem(v)
		

	end
	_menuPool:RefreshIndex()
	
	menu.OnIndexChange = function(menu,index6)
		local index2 = 1
		
		playerPed = GetPlayerPed(-1)
		SetPedPropIndex(playerPed, 0, index6-1, 0, 2)
		menu.OnListSelect = function(_, _, _)
			pdka = index2 - 1 
			TriggerServerEvent("parow:SetNewMasque",index6-1,pdka,	"Chapeau",chapeauItem[index6],0)
		end
		menu.OnListChange = function(_, _, index26)
			index2 = index26
			SetPedPropIndex(playerPed, 0, index6-1, index26-1, 2)
		end
	end
else

end 

end






local menuLoaded = false
local clotheShop = NativeUI.CreateMenu("", "Shop", 5, 100,"shopui_title_midfashion","shopui_title_midfashion")
function OpenClotheShop()
	TriggerEvent("parow:exit")
	
	if menuLoaded == false  then
		
		_menuPool:Add(clotheShop)
		ClotheShopAdd(clotheShop)
		menuLoaded = true
	--	clotheShop:Visible(not clotheShop:Visible())
--	Citizen.Wait(200)
	_menuPool:RefreshIndex()
	clotheShop:Visible(not clotheShop:Visible())
	else
		_menuPool:CloseAllMenus()
		print("MENULOADED")
		clotheShop:Visible(not clotheShop:Visible())
		
end
	
	

end



_menuPool:RefreshIndex()



























-- function

Citizen.CreateThread(function()
	--OpenClotheShop()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)

	end
	
	TriggerEvent('parow:exit')
end)



AddEventHandler('clothesShop:hasEnteredMarker', function(zone)

	CurrentAction6     = 'shop_menu'
	CurrentAction6Msg  = 'Press ~INPUT_CONTEXT~ to shop.'
	CurrentAction6Data = {zone = zone}

end)

AddEventHandler('clothesShop:hasExitedMarker', function(_)

	CurrentAction6 = nil
	CurrentAction6Msg = nil
	TriggerEvent("parow:exit")
	_menuPool:CloseAllMenus()
	if MenuOn then
		RecupTenues()
		MenuOn = false
	end
end)
 


-- Display markers
Citizen.CreateThread(function()
  while true do
	Wait(0)
	--print("oyo")
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for _,v in pairs(ConfigclotheShop.Zones) do
      for i = 1, #v.Pos, 1 do
        if(ConfigclotheShop.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < ConfigclotheShop.DrawDistance) then
          DrawMarker(ConfigclotheShop.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, ConfigclotheShop.Size.x, ConfigclotheShop.Size.y, ConfigclotheShop.Size.z, ConfigclotheShop.Color.r, ConfigclotheShop.Color.g, ConfigclotheShop.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end
    end
  end
end)
-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Wait(1000)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(ConfigclotheShop.Zones) do
			for i = 1, #v.Pos, 1 do
				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 1.5) then
					isInMarker  = true
					ShopItems   = v.Items
					currentZone = k
					LastZone    = k
				end
			end
		end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('clothesShop:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('clothesShop:hasExitedMarker', LastZone)
			--("s")
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  
	  if CurrentAction6 ~= nil then
		SetTextComponentFormat('STRING')
		AddTextComponentString(CurrentAction6Msg)
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  
		if IsControlJustReleased(0, 38) then
		--	TriggerEvent("onClientMaspStart")
		
			
			OpenClotheShop()
			recp()
			MenuOn = true
	--	  CurrentAction6 = nil
  
		end
  
	  end
	end
  end)


  function recp()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
  end

  Citizen.CreateThread(function()

    while true do

        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if (IsControlJustReleased(0, Keys["K"])) then
            _menuPool:CloseAllMenus()
            OpenAccessMenus()
		end
    end
end)
local mainMenu = nil
function OpenAccessMenus()
    _menuPool:CloseAllMenus()
    mainMenu = NativeUI.CreateMenu("My accessories", "Accessories available", 5, 200)
    _menuPool:Add(mainMenu)
    RefreshData()



end
function RefreshData()
    ESX.TriggerServerCallback("parow:getMask", function(result)
		MaskTab = result
		maskMenu(mainMenu)
    end)
end
function maskMenu(menu)
    local accessories = { "Mask", "Hat", "Glasses", "Earings", "Bulletproof vest" }
    local accessoriesIndex = { "mask", "hat", "glasses", "ears", "gilet" }
    xss = NativeUI.CreateListItem("To take off", accessories, 1, "")
    menu:AddItem(xss)
    menu.OnListSelect = function(m, item, index)
        if item == xss then
            accessory = accessoriesIndex[index]

            if accessory == "mask" then
                SetPedComponentVariation(playerPed, 1, 0, 0, 2)
            end
            if accessory == "glasses" then
                ClearPedProp(playerPed, 1)


            end
            if accessory == "hat" then
                ClearPedProp(playerPed, 0)

            end
            if accessory == "ears" then
                ClearPedProp(playerPed, 2)


            end
        end


    end
        result = MaskTab
        --(json.encode(result))
        if #result == 0 then
            u = NativeUI.CreateItem("Empty", "")
            menu:AddItem(u)
        else

            for i = 1, #result, 1 do
				menumbk = menu
				_menuPool:RefreshIndex()
                local xfvde = _menuPool:AddSubMenu(menu, result[i].label, "", 5, 200)

                xl = NativeUI.CreateItem("Equip", "")
                xc = NativeUI.CreateItem("Rename", "")
                xv = NativeUI.CreateItem("Give", "")
                xb = NativeUI.CreateItem("Throw away", "")
                xfvde:AddItem(xl)
                xfvde:AddItem(xc)
                xfvde:AddItem(xv)
                xfvde:AddItem(xb)
                xfvde.OnItemSelect = function(menu, _, index)
                 --   i = i+1
                    if index == 1 then
                        k = json.decode(result[i].mask)
                        ped = GetPlayerPed(-1)
                        uno = k.mask_1
                        dos = k.mask_2
                        typos = result[i].type
                        --(typos)
                        if typos == "Mask" then

                            if ped then
                                local dict = 'missfbi4'
                                local myPed = PlayerPedId()
                                RequestAnimDict(dict)

                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end

                                local animation = ''
                                local flags = 0 -- only play the animation on the upper body
                                animation = 'takeoff_mask'
                                TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                Citizen.Wait(1000)
                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                playerPed = GetPlayerPed(-1)
                                SetPedComponentVariation(playerPed, 1, k.mask_1, k.mask_2, 2)
                                Citizen.Wait(200)
                                ClearPedTasks(playerPed)
                            end
                        elseif typos == "Glasses" then

                            if ped then
                                local dict = 'clothingspecs'
                                local myPed = PlayerPedId()
                                RequestAnimDict(dict)

                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end

                                local animation = ''
                                local flags = 0 -- only play the animation on the upper body
                                animation = 'try_glasses_positive_a'
                                TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                Citizen.Wait(1000)
                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                playerPed = GetPlayerPed(-1)
                                SetPedPropIndex(playerPed, 1, k.mask_1, k.mask_2, 2)
                                Citizen.Wait(200)
                                ClearPedTasks(playerPed)
                            end

                        elseif typos == "Hat" then

                            if ped then
                                local dict = 'missheistdockssetup1hardhat@'
                                local myPed = PlayerPedId()
                                RequestAnimDict(dict)

                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end

                                local animation = ''
                                local flags = 0 -- only play the animation on the upper body
                                animation = 'put_on_hat'
                                TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                Citizen.Wait(1000)
                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                playerPed = GetPlayerPed(-1)
                                SetPedPropIndex(playerPed, 0, k.mask_1, k.mask_2, 2)
                                Citizen.Wait(200)
                                ClearPedTasks(playerPed)
                            end
                        elseif typos == "Loop" then

                            if ped then
                                local dict = 'mp_masks@standard_car@rps@'
                                local myPed = PlayerPedId()
                                RequestAnimDict(dict)

                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end

                                local animation = ''
                                local flags = 0 -- only play the animation on the upper body
                                animation = 'put_on_mask'
                                TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                Citizen.Wait(1000)
                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                playerPed = GetPlayerPed(-1)
                                SetPedPropIndex(playerPed, 2, k.mask_1, k.mask_2, 2)
                                Citizen.Wait(200)
                                ClearPedTasks(playerPed)
                            end


                        end
                    end
                    if index == 2 then
                        typos = result[i].type
                        txt = gettxt2(result[i].label)
                        txt = tostring(txt)
                        if txt ~= nil then
                            TriggerServerEvent("parow:RenameMasque", result[i].id, txt, typos)
                          --  _menuPool:CloseAllMenus()
                          k = menumbk:GetItemAt(i+1)
                          k:UpdateText(txt)
                          menu:GoBack()
                          result[i].label = txt

                        end

                    end
                    if index == 3 then
                        local myPed = PlayerPedId()
                        if result[i].index == 99 then
                            SetPedComponentVariation(playerPed, 1, 0, 0, 2)
                        else
                            ClearPedProp(myPed, result[i].index)
                        end
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        local closestPed = GetPlayerPed(closestPlayer)

                        if IsPedSittingInAnyVehicle(closestPed) then
                            ESX.ShowNotification('~r~Cannot donate an item in a vehicle')
                            return
                        end

                        if closestPlayer ~= -1 and closestDistance < 3.0 then

                            TriggerServerEvent('prw:GiveAccessories', GetPlayerServerId(closestPlayer), result[i].id, result[i].label)


                            menu:GoBack()

                          --  _menuPool:RefreshIndex()
                            table.remove( MaskTab, i  )
                            menumbk:RemoveItemAt(i+1)

                        else
                            ESX.ShowNotification("~r~No nearby players")

                        end


                    end
                    if index == 4 then
                        TriggerServerEvent('prw:Delclo', result[i].id, result[i].label,result[i])

                        menu:GoBack()

                        --_menuPool:RefreshIndex()
                        table.remove( MaskTab, i  )
                        menumbk:RemoveItemAt(i+1)

                    end
                end
                --    menu:AddItem(psp)
                -- _menuPool:RefreshIndex()
            end
		end
		menu:Visible(true)
end


