--Skelris' Admin Commands--

---------------------------------------------------------------------------------------------------------------
---DO NOT EDIT ANYTHING BELOW!! ALL EDITS MUST BE MADE INSIDE THE "Skel_Options" SCRIPT INSIDE THIS SCRIPT!!---
---------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------
---DO NOT REMOVE, MOVE, OR CHANGE ANYTHING THAT IS INSIDE OR IS A DESCENDANT OF THIS SCRIPT!! LEAVE EVERYTHING AS IS OR THERE MAY BE ISSUES RUNNING IT!!---
-----------------------------------------------------------------------------------------------------------------------------------------------------------

local WasNotInserted = true
if not script:FindFirstChild("Skel_AdminOptions") then
	WasNotInserted = false
end

local MyModule = game:GetService("ServerStorage"):FindFirstChild("Skel_AdminOptions") or script.Skel_AdminOptions
MyModule.Parent = game:GetService("ServerStorage")
local MyOptions = require(MyModule)

---Admins---
local ultraadmins = MyOptions.ultraadmins or {}
local superadmins = MyOptions.superadmins or {}
local admins = MyOptions.admins or {}

---Banlist---
local banlist = MyOptions.banlist or {}
local mutelist = MyOptions.mutelist or {}

---Group Admin---
local GroupAdminOn = MyOptions.GroupAdminOn or false
local GroupID = MyOptions.GroupID or 0
local GroupRankUltra = MyOptions.GroupRankUltra or 0
local GroupRankSuper = MyOptions.GroupRankSuper or 0
local GroupRankAdmin = MyOptions.GroupRankAdmin or 0

---Gamepass Admin---
local GPAdminOn = MyOptions.GPAdminOn or false
local GamepassID = MyOptions.GamepassID or 0
local GPBanList = MyOptions.GPBanList or {}

---Notification Settings---
local NotificationsOn = MyOptions.NotificationsOn if NotificationsOn == nil then NotificationsOn = true end
local PlayerEnterNotify = MyOptions.PlayerEnterNotify if PlayerEnterNotify == nil then PlayerEnterNotify = true end
local PlayerLeaveNotify = MyOptions.PlayerLeaveNotify if PlayerLeaveNotify == nil then PlayerLeaveNotify = true end
local JoinAttemptNotify = MyOptions.JoinAttemptNotify if JoinAttemptNotify == nil then JoinAttemptNotify = true end

---Options---
local DefaultPrefix = MyOptions.DefaultPrefix or ">"
local FunCommands = MyOptions.FunCommands if FunCommands == nil then FunCommands = true end
local AutoHatClean = AutoHatClean if AutoHatClean == nil then AutoHatClean = false end
local AutoToolClean = MyOptions.AutoToolClean if AutoToolClean == nil then AutoToolClean = false end
local NegEffectsOff = MyOptions.NegEffectsOff if NegEffectsOff == nil then NegEffectsOff = true end
local FooterEnabled = MyOptions.FooterEnabled if FooterEnabled == nil then FooterEnabled = true end





local RawCmds = {"viewprefix"}
local PublicCmds = {"commands","changeprefix","changecolor"}
local AdminCmds = {"clean","clear","fix","m [text]","pm [plr] [text]","sm [text]","h [text]","countdown [num]","stopcountdown","n [text]","sn [text]","admins","bans","commandlogs","tools","time","brightness","ambient","fogcolor","fogend","fogstart","disco","undisco","kill [plr]","explode [plr]","respawn [plr]","heal [plr]","damage [plr] [num]","ff [plr]","unff [plr]","god [plr]","ungod [plr]","freeze [plr]","thaw [plr]","clone [plr]","music [sound ID]","stopmusic","team [plr] [team]","give [plr] [tool]","take [plr] [tool]","startergive [plr] [tool]","startertake [plr] [tool]","viewtools [plr]","viewstartertools [plr]","btools [plr]","cleartools [plr]","walkspeed [plr] [num]","highgrav [plr]","grav [plr]","lowgrav [plr]","nograv [plr]","setgrav [plr] [num]","fling [plr]","name [plr] [text]","unname [plr]","tp [plr] [plr]","saveteleport","loadteleport","swap [plr] [plr]","sit [plr]","jump [plr]","trip [plr]","stun [plr]","unstun [plr]","noclip [plr]","clip [plr]","hat [plr] [ID]","gear [plr] [ID]","sparkles [plr]","unsparkles [plr]","smoke [plr]","unsmoke [plr]","fire [plr]","unfire [plr]","light [plr]","unlight [plr]","lock [plr]","unlock [plr]","invisible [plr]","visible [plr]","ghostify [plr]","char [plr] [ID]","unchar [plr]","plrchar [plr] [plr]","randomchar [plr]","clearlimbs [plr]","clrapp [plr]","noobify [plr]"}
local SuperCmds = {"admin [plr]","unadmin [plr]","kick [plr]","ban [plr]","unban [plr]","loopkill [plr]","unloopkill [plr]","serverlock","serverunlock","grouplock","groupunlock","shutdown","place [plr] [game ID]"}
local UltraCmds = {"sa [plr]", "unsa [plr]","chatoff [plr]","chaton [plr]","hatcleanon","hatcleanoff","toolcleanon","toolcleanoff", "spawnpad"}
local OwnerCmds = {"ua [plr]", "unua [plr]","funcmdson","funcmdsoff", "spawngoldpad", "spawn3pads"}

local CommandLogs = {}

local InsertService = game:GetService("InsertService")

local SystemThumbnail = "rbxassetid://214286140"
local CharacterThumbnailPrefix = "http://www.roblox.com/Thumbs/Avatar.ashx?x=200&y=200&Format=Png&username="

local RegLineColor = Color3.new(0/255,170/255,255/255)
local BanLineColor = Color3.new(255/255,0/255,0/255)
local KickLineColor = Color3.new(255/255,170/255,0/255)
local EnterLineColor = Color3.new(0/255,170/255,0/255)

local RegNotColor = Color3.new(243/255,243/255,243/255)
local BanNotColor = Color3.new(255/255,200/255,200/255)
local KickNotColor = Color3.new(255/255,255/255,200/255)
local EnterNotColor = Color3.new(200/255,255/255,200/255)


local FoundSkelScripts = 0
for i, v in pairs(game.Workspace:GetChildren()) do
	coroutine.resume(coroutine.create(function()
		if v.Name == script.Name then
			if FoundSkelScripts > 0 then
				v:Destroy()
			end
			FoundSkelScripts = FoundSkelScripts + 1
		end
	end))
end
print("Cleared " .. FoundSkelScripts-1 .. " Skel scripts")


local OwnerName = game.CreatorId

function GetAdminLevel(plr)
	local AdminLevel = 0
	
	for i, v in pairs(admins) do
		if v:lower() == plr.Name:lower() then
			AdminLevel = 1
			break
		end
	end
	
	for i, v in pairs(superadmins) do
		if v:lower() == plr.Name:lower() then
			AdminLevel = 2
			break
		end
	end
	
	for i, v in pairs(ultraadmins) do
		if v:lower() == plr.Name:lower() then
			AdminLevel = 3
			break
		end
	end
	
	if plr.userId == game.CreatorId then
		AdminLevel = 4
	end

	
	return AdminLevel
end

function CheckIfBanned(plr)
	for i, v in pairs(banlist) do
		if plr.Name:lower() == v:lower() then
			return true
		end
	end
	return false
end

function CheckIfMuted(plr)
	for i, v in pairs(mutelist) do
		if plr.Name:lower() == v:lower() then
			return true
		end
	end
	return false
end

game.Workspace.ChildAdded:connect(function(child)
	if child:IsA("Hat") and AutoHatClean then
		child:Destroy()
	elseif child:IsA("Tool") and AutoToolClean then
		child:Destroy()
	end
end)

function ScreenMessage(plr, Header, Body)
	coroutine.resume(coroutine.create(function()
		if script:FindFirstChild("Skel_Storage") then
			if script.Skel_Storage:FindFirstChild("SM_Close") then
				if plr:FindFirstChild("PlayerGui") then
					if plr.PlayerGui:FindFirstChild("Skel_ScreenMessage") or not plr:FindFirstChild("Skel_SystemColor") then
						local f = Instance.new("Folder", plr)
						f.Name = "Skel_PendingMessage"
						
						local s1 = Instance.new("StringValue", f)
						s1.Name = "Header"
						s1.Value = Header
						
						local s2 = Instance.new("StringValue", f)
						s2.Name = "Body"
						s2.Value = Body
					else
						if not plr:FindFirstChild("Skel_CurrentSM") then
							local f = Instance.new("Folder", plr)
							f.Name = "Skel_CurrentSM"
							
							local s1 = Instance.new("StringValue", f)
							s1.Name = "Header"
							s1.Value = Header
							
							local s2 = Instance.new("StringValue", f)
							s2.Name = "Body"
							s2.Value = Body
						end
						
						local s = Instance.new("ScreenGui", plr.PlayerGui)
						s.Name = "Skel_ScreenMessage"
						
						local f1 = Instance.new("Frame", s)
						f1.Name = "Background"
						f1.Size = UDim2.new(1,0,1,0)
						f1.Position = UDim2.new(-1,0,0,0)
						f1.BackgroundColor3 = Color3.new(27/255,27/255,27/255)
						f1.BorderSizePixel = 0
						f1.BackgroundTransparency = 0.5
						f1.ZIndex = 9
						
						local f2 = Instance.new("Frame", f1)
						f2.Name = "Banner"
						f2.BackgroundColor3 = plr.Skel_SystemColor.Value
						f2.Size = UDim2.new(1,0,0.3,0)
						f2.Position = UDim2.new(0,0,0.35,0)
						f2.ZIndex = 9
						
						local t1 = Instance.new("TextLabel", f2)
						t1.Name = "Header"
						t1.BackgroundTransparency = 1
						t1.Position = UDim2.new(0.2,0,0,0)
						t1.Size = UDim2.new(0.6,0,0.2,0)
						t1.ZIndex = 9
						t1.Text = Header
						t1.TextColor3 = Color3.new(1,1,1)
						t1.TextScaled = true
						t1.TextStrokeTransparency = 0
						t1.TextWrapped = true
						t1.TextXAlignment = Enum.TextXAlignment.Left
						
						local t2 = t1:Clone()
						t2.Name = "Body"
						t2.Parent = t1.Parent
						t2.Position = UDim2.new(0.2,0,0.2,0)
						t2.Size = UDim2.new(0.6,0,0.5,0)
						t2.Text = Body
						t2.TextStrokeTransparency = 0.5
						t2.TextYAlignment = Enum.TextYAlignment.Top
						
						local btn = script.Skel_Storage.SM_Close:Clone()
						btn.Parent = f2
						
						f1:TweenPosition(UDim2.new(0,0,0,0), "In", "Quad", 0.75)
					end
				end
			end
		end
	end))
end

function Hint(msg, UserName, plr)
	coroutine.resume(coroutine.create(function()
		if plr:FindFirstChild("PlayerGui") then
			for i, v in pairs(plr.PlayerGui:GetChildren()) do
				coroutine.resume(coroutine.create(function()
					if v.Name == "Skel_Hint" then
						local yPos = v.HintMessage.Position.Y.Offset
						local yPos = yPos + 20
						v.HintMessage.Position = UDim2.new(0,0,0,yPos)
					end
				end))
			end
			
			local s = Instance.new("ScreenGui", plr.PlayerGui)
			s.Name = "Skel_Hint"
			
			local t = Instance.new("TextLabel", s)
			t.Name = "HintMessage"
			t.BackgroundColor3 = Color3.new(75/255,75/255,75/255)
			t.BackgroundTransparency = 0.5
			t.Size = UDim2.new(1,0,0,20)
			t.Position = UDim2.new(0,0,0,0)
			t.ZIndex = 9
			t.Text = UserName..": "..msg
			t.TextColor3 = Color3.new(1,1,1)
			t.TextScaled = true
			t.TextStrokeTransparency = 0
			
			game:GetService("Debris"):AddItem(s, 7)
		end
	end))
end

local CountGoing = false

function Countdown(StartNumber)
	CountGoing = true
	
	local BlueFill = Color3.new(0/255,170/255,255/255)
	local BlueOutline = Color3.new(0/255,85/255,255/255)
	
	local YellowFill = Color3.new(255/255,255/255,127/255)
	local YellowOutline = Color3.new(255/255,170/255,0/255)
	
	local RedFill = Color3.new(255/255,44/255,44/255)
	local RedOutline = Color3.new(255/255,10/255,10/255)
	
	for i, v in pairs(game.Players:GetPlayers()) do
		coroutine.resume(coroutine.create(function()
			if v:FindFirstChild("PlayerGui") then
				local s = Instance.new("ScreenGui", v.PlayerGui)
				s.Name = "Skel_Countdown"
				
				for i = StartNumber, 1, -1 do
					if CountGoing == false then
						break
					end
					
					coroutine.resume(coroutine.create(function()
						if s ~= nil then
							local t = Instance.new("TextLabel")
							t.Name = "Second"
							t.BackgroundTransparency = 1
							t.Position = UDim2.new(0.4,0,0.2,0)
							t.Size = UDim2.new(0.2,0,0.1,0)
							t.ZIndex = 9
							t.Font = "ArialBold"
							t.Text = tostring(i)
							t.TextScaled = true
							t.TextStrokeTransparency = 0
							
							if i <= 3 then
								t.TextColor3 = RedFill
								t.TextStrokeColor3 = RedOutline
							elseif i <= 10 then
								t.TextColor3 = YellowFill
								t.TextStrokeColor3 = YellowOutline
							else
								t.TextColor3 = BlueFill
								t.TextStrokeColor3 = BlueOutline
							end
							
							t.Parent = s
							
							game:GetService("Debris"):AddItem(t, 1)
							
							wait(0.2)
							
							for u = 0, 1.05, 0.05 do
								t.TextTransparency = u
								t.TextStrokeTransparency = u
								wait()
							end
						end
					end))
					wait(1)
				end
				
				s:Destroy()
			end
		end))
	end
	
	for i = 1, StartNumber do
		if CountGoing == false then
			break
		end
		wait(1)
	end
	
	CountGoing = false
end

function GenerateNotification(plr, NotHeader, NotBody, LineColor, NotColor, NotThumbnail)
	if LineColor == nil then
		LineColor = RegLineColor
	end
	
	if NotColor == nil then
		NotColor = RegNotColor
	end
	
	if NotThumbnail == nil then
		NotThumbnail = SystemThumbnail
	end
	
	if NotificationsOn then
		if script:FindFirstChild("Skel_Storage") then
			if script.Skel_Storage:FindFirstChild("Skel_Notification") then
				local NewNot = script.Skel_Storage.Skel_Notification:Clone()
				NewNot.Container.NotificationBody.Header.Text = NotHeader
				NewNot.Container.NotificationBody.Input.Text = NotBody
				NewNot.Container.ColorLine.BackgroundColor3 = LineColor
				NewNot.Container.BackgroundColor3 = NotColor
				NewNot.Container.Thumbnail.Image = NotThumbnail
				
				if plr:FindFirstChild("PlayerGui") and plr:FindFirstChild("Skel_MinXLength") and plr:FindFirstChild("Skel_MinYLength") then
					local ScreenGui = Instance.new("ScreenGui", plr)
					local Frame = Instance.new("Frame", ScreenGui)
					
					local MinXObject = plr.Skel_MinXLength
					local MinYObject = plr.Skel_MinYLength
					
					Frame.Position = UDim2.new(0.5,0,0.5,0)
					
					MinXObject.Value = Frame.AbsolutePosition.X
					MinYObject.Value = Frame.AbsolutePosition.Y
					
					ScreenGui:Destroy()
					
					local MinX = plr.Skel_MinXLength.Value
					local MinY = plr.Skel_MinYLength.Value
					
					for i, v in pairs(plr.PlayerGui:GetChildren()) do
						if v.Name == "Skel_Notification" then
							if v:FindFirstChild("Container") then
								local CurY = v.Container.Position.Y.Offset
								v.Container.Position = UDim2.new(1,-260,1,CurY-60)
								if v.Container.AbsolutePosition.X < MinX or v.Container.AbsolutePosition.Y < MinY then
									v:Destroy()
								end
							end
						end
					end
					
					NewNot.Parent = plr.PlayerGui
					
					game.Debris:AddItem(NewNot, 10)
					
					if NewNot.Container.AbsolutePosition.X < MinX or NewNot.Container.AbsolutePosition.Y < MinY then
						NewNot:Destroy()
					end
				end
			end
		end
	end
end

function InfoGUI(gui, InputHeadText, MyTableList)
	if script:FindFirstChild("Skel_Storage") and script.Skel_Storage:FindFirstChild("Close") and script.Skel_Storage.Close:FindFirstChild("LocalScript") then
		local interface = Instance.new("Frame", gui)
		interface.Name = "Interface"
		interface.Position = UDim2.new(0.3,0,0.2,0)
		interface.Size = UDim2.new(0.4,0,0.6,0)
		interface.Style = "DropShadow"
		interface.ZIndex = 9
		
		local header = Instance.new("Frame", interface)
		header.Name = "Header"
		header.Size = UDim2.new(1,0,0.2,0)
		header.Style = "RobloxRound"
		header.ZIndex = 9
		
		local headtext = Instance.new("TextLabel", header)
		headtext.Name = "HeaderText"
		headtext.BackgroundTransparency = 1
		headtext.Size = UDim2.new(1,0,1,-20)
		headtext.Position = UDim2.new(0,0,0,20)
		headtext.Text = InputHeadText
		headtext.TextColor3 = Color3.new(1,1,1)
		headtext.TextScaled = true
		headtext.TextStrokeTransparency = 0
		headtext.ZIndex = 9
		
		local list = Instance.new("Frame", interface)
		list.Name = "List"
		list.Position = UDim2.new(0,0,0.2,0)
		list.Size = UDim2.new(1,0,0.8,0)
		list.Style = "RobloxRound"
		list.ZIndex = 9
		
		local scrollback = Instance.new("Frame", list)
		scrollback.Name = "ScrollBack"
		scrollback.BackgroundColor3 = Color3.new(1,1,1)
		scrollback.Size = UDim2.new(1,0,1,0)
		scrollback.ZIndex = 9
		
		local listscroll = Instance.new("ScrollingFrame", list)
		listscroll.Name = "ListScroll"
		listscroll.BackgroundColor3 = Color3.new(1,1,1)
		listscroll.BackgroundTransparency = 1
		listscroll.Size = UDim2.new(1,0,1,0)
		listscroll.ZIndex = 10
		
		local closebtn = script.Skel_Storage.Close:Clone()
		closebtn.Parent = interface
		
		local AccNum = 0
		local OrigScale = 1/15
		local ScaleNum = 1/15
		
		for i, v in pairs(MyTableList) do
			AccNum = AccNum + #v
		end
		
		if AccNum > 15 then
			local NewNum = AccNum - 15
			local DivNum = 1
			
			DivNum = DivNum + (OrigScale*NewNum)
			
			ScaleNum = ScaleNum / DivNum
		else
			scrollback.Size = UDim2.new(1,0,(1/15)*AccNum,0)
		end
		
		listscroll.CanvasSize = UDim2.new(0,0,OrigScale*AccNum,0)
		
		local ItemTake = Instance.new("TextLabel")
		ItemTake.Name = "ListItem"
		ItemTake.Size = UDim2.new(1,0,ScaleNum,0)
		ItemTake.Font = "ArialBold"
		ItemTake.Text = ""
		ItemTake.TextColor3 = Color3.new(1,1,1)
		ItemTake.TextScaled = true
		ItemTake.TextStrokeTransparency = 0
		ItemTake.TextXAlignment = "Left"
		ItemTake.ZIndex = 9
		
		if AccNum > 10 then
			ItemTake.Size = UDim2.new(1,-12,ScaleNum,0)
		end
		
		local RoundNum = 1
		
		for u, c in pairs(MyTableList) do
			for i, v in pairs(c) do
				local item = ItemTake:Clone()
				item.Text = v
				
				if RoundNum % 2 == 0 then
					item.BackgroundColor3 = Color3.new(50/255,50/255,50/255)
				else
					item.BackgroundColor3 = Color3.new(100/255,100/255,100/255)
				end
				
				if i == 1 then
					item.TextXAlignment = "Center"
					item.BackgroundColor3 = Color3.new(0/255,85/255,255/255)
				end
				item.Position = UDim2.new(0,0,(ScaleNum*RoundNum)-ScaleNum,0)
				item.Parent = listscroll
				RoundNum = RoundNum + 1
			end
		end
		
		ItemTake:Destroy()
	else
		gui:Destroy()
	end
end

function GetItems(names, InputTable, TypeTable, plr)
	local ReturnNames = {}
	
	for i, v in pairs(InputTable) do
		if v.Name == names then
			table.insert(ReturnNames, v)
			return ReturnNames
		end
	end
	
	if names:lower() == "all" and TypeTable ~= "Teams" then
		return InputTable
	elseif names:lower() == "others" and TypeTable == "Players" then
		local ReturnNames = InputTable
		for i, v in pairs(ReturnNames) do
			if v == plr then
				table.remove(ReturnNames, i)
				break
			end
		end
		return ReturnNames
	elseif names:lower() == "me" and TypeTable == "Players" then
		table.insert(ReturnNames, plr)
		return ReturnNames
	elseif names:lower() == "random" then
		local AllItems = InputTable
		if #AllItems > 0 then
			local x = math.random(1, #AllItems)
			table.insert(ReturnNames, AllItems[x])
		end
		return ReturnNames
	elseif names:lower() == "admins" and TypeTable == "Players" then
		for i, v in pairs(InputTable) do
			if GetAdminLevel(v) >= 1 then
				table.insert(ReturnNames, v)
			end
		end
		return ReturnNames
	elseif names:lower() == "nonadmins" and TypeTable == "Players" then
		for i, v in pairs(InputTable) do
			if not GetAdminLevel(v) == 0 then
				table.insert(ReturnNames, v)
			end
		end
		return ReturnNames
	elseif names:lower() == "friends" and TypeTable == "Players" then
		for i, v in pairs(InputTable) do
			if v:IsFriendsWith(plr.userId) and v ~= plr then
				table.insert(ReturnNames, v)
			end
		end
	elseif names:lower() == "nonfriends" and TypeTable == "Players" then
		for i, v in pairs(InputTable) do
			if not v:IsFriendsWith(plr.userId) then
				table.insert(ReturnNames, v)
			end
		end
	elseif names:lower() == "guests" and TypeTable == "Players" then
		for i, v in pairs(InputTable) do
			if v.Name:sub(1, 6):lower() == "guest " then
				table.insert(ReturnNames, v)
			end
		end
	elseif names:lower() == "nonguests" and TypeTable == "Players" then
		for i, v in pairs(InputTable) do
			if v.Name:sub(1, 6):lower() ~= "guest " then
				table.insert(ReturnNames, v)
			end
		end
	elseif names:sub(1, 5):lower() == "team[" and TypeTable == "Players" then
		if #game:GetService("Teams"):GetChildren() > 0 then
			if names:sub(#names) == "]" then
				local TeamName = names:sub(6, #names-1):lower()
				for i, v in pairs(game:GetService("Teams"):GetChildren()) do
					if v.Name:lower() == TeamName then
						for u, c in pairs(InputTable) do
							if c.TeamColor == v.TeamColor then
								table.insert(ReturnNames, c)
							end
						end
					end
				end
			end
		end
		return ReturnNames
	else
		for i, v in pairs(InputTable) do
			if v.Name:sub(1, #names):lower() == names:lower() then
				table.insert(ReturnNames, v)
			end
		end
		return ReturnNames
	end
	
	return ReturnNames
end

function NameScan(names, InputTable, IsPlayers, plr)
	local ReturnNames = {}
	local ReturnRawNames = {}
	local Comma1 = nil
	local Comma2 = nil
	
	local function CheckIfName(input)
		for i, v in pairs(ReturnNames) do
			if v == input then
				return true
			end
		end
		return false
	end
	
	for i = 1, #names do
		if names:sub(i, i) == "," then
			Comma1 = i
			
			if Comma2 ~= nil then
				local GiveNames = names:sub(Comma2+1, Comma1-1)
				
				local SaidNames = GetItems(GiveNames, InputTable, IsPlayers, plr)
				table.insert(ReturnRawNames, GiveNames)
				
				for u, c in pairs(SaidNames) do
					if not CheckIfName(c) then
						table.insert(ReturnNames, c)
					end
				end
				
				Comma2 = Comma1
			elseif Comma2 == nil then
				local GiveNames = names:sub(1, Comma1-1)
				
				local SaidNames = GetItems(GiveNames, InputTable, IsPlayers, plr)
				table.insert(ReturnRawNames, GiveNames)
				
				for u, c in pairs(SaidNames) do
					if not CheckIfName(c) then
						table.insert(ReturnNames, c)
					end
				end
				
				Comma2 = Comma1
			end
		elseif i == #names then
			if Comma2 ~= nil then
				local GiveNames = names:sub(Comma2+1, #names)
				
				local SaidNames = GetItems(GiveNames, InputTable, IsPlayers, plr)
				table.insert(ReturnRawNames, GiveNames)
				
				for u, c in pairs(SaidNames) do
					if not CheckIfName(c) then
						table.insert(ReturnNames, c)
					end
				end
			else
				local GiveNames = names:sub(1)
				
				local SaidNames = GetItems(GiveNames, InputTable, IsPlayers, plr)
				table.insert(ReturnRawNames, GiveNames)
				
				for u, c in pairs(SaidNames) do
					if not CheckIfName(c) then
						table.insert(ReturnNames, c)
					end
				end
			end
		end
	end
	
	return {ReturnNames, ReturnRawNames}
end

local AdminTypes = {"an admin","a super admin","an ultra admin","an owner admin",";o"}

function GiveAdmin(plr, AdminType, LevelOfAdmin, LowerAdminTypes)
	if GetAdminLevel(plr) < LevelOfAdmin then
		table.insert(AdminType, plr.Name)
		
		if plr:FindFirstChild("Skel_Prefix") then
			local MyPrefix = plr.Skel_Prefix.Value
			ScreenMessage(plr, "System Message", "You are "..AdminTypes[LevelOfAdmin].."! The prefix is '"..MyPrefix.."'.")
		end
		
		for u, c in pairs(LowerAdminTypes) do
			for i, v in pairs(c) do
				if v:lower() == plr.Name:lower() then
					table.remove(c, i)
				end
			end
		end
	end
end

function TakeAdmin(InputName, AdminType)
	local l = InputName:len()
	
	for i, v in pairs(AdminType) do
		if v:sub(1, l):lower() == InputName:lower() then
			table.remove(AdminType, i)
		end
	end
end

function CheckGroupAdmin(plr)
	if GroupAdminOn then
		if plr:IsInGroup(GroupID) then
			if plr:GetRankInGroup(GroupID) >= GroupRankUltra then
				GiveAdmin(plr, ultraadmins, 3, {admins, superadmins})
			elseif plr:GetRankInGroup(GroupID) >= GroupRankSuper then
				GiveAdmin(plr, superadmins, 2, {admins})
			elseif plr:GetRankInGroup(GroupID) >= GroupRankAdmin then
				GiveAdmin(plr, admins, 1, {})
			end
		end
	end
end

local GPAdminOn = MyOptions.GPAdminOn or false
local GamepassID = MyOptions.GamepassID or 0
local GPBanList = MyOptions.GPBanList or {}

function CheckGamepassAdmin(plr)
	if GPAdminOn then
		local GiveAdmin = true
		
		for i, v in pairs(GPBanList) do
			if v:lower() == plr.Name:lower() then
				GiveAdmin = false
			end
		end
		
		if GiveAdmin then
			if GetAdminLevel(plr) < 1 then
				if game:GetService("GamePassService"):PlayerHasPass(plr, GamepassID) then
					GiveAdmin(plr, admins, 1, {})
				end
			end
		end
	end
end

function GiveParticles(ParticleType, plr)
	if plr.Character then
		if plr.Character:FindFirstChild("Torso") then
			Instance.new(ParticleType, plr.Character.Torso)
		end
	end
end

function TakeParticles(ParticleType, plr)
	if plr.Character then
		if plr.Character:FindFirstChild("Torso") then
			local particles = plr.Character.Torso:GetChildren()
			
			for i, v in pairs(particles) do
				if v:IsA(ParticleType) then
					v:Destroy()
				end
			end
		end
	end
end

local KickedPlayers = {}
local ScriptDebris = {}

local LoopKills = {}

local ServerLocked = false

function ServerIsLocked(plr)
	if ServerLocked then
		if GetAdminLevel(plr) == 0 then
			return true
		end
		return false
	end
	return false
end

local GroupLocked = false

function ServerIsGroupLocked(plr)
	if GroupLocked then
		if GroupAdminOn then
			if not plr:IsInGroup(GroupID) and GetAdminLevel(plr) == 0 then
				return true
			end
			return false
		end
		return false
	end
	return false
end

local DiscoOn

local Skel_Ambient = game:GetService("Lighting").Ambient
local Skel_Brightness = game:GetService("Lighting").Brightness
local Skel_GlobalShadows = game:GetService("Lighting").GlobalShadows
local Skel_Outlines = game:GetService("Lighting").Outlines
local Skel_TimeOfDay = game:GetService("Lighting").TimeOfDay
local Skel_FogColor = game:GetService("Lighting").FogColor
local Skel_FogEnd = game:GetService("Lighting").FogEnd
local Skel_FogStart = game:GetService("Lighting").FogStart

function AdminCommands(msg, rec, plr)
	if msg:sub(1, 3):lower() == "/e " and msg:len() > 3 then
		msg = msg:sub(4)
	end
	
	if msg:lower() == "viewprefix" then
		if plr:FindFirstChild("Skel_Prefix") then
			if plr:FindFirstChild("PlayerGui") then
				local s = Instance.new("ScreenGui", plr.PlayerGui)
				s.Name = "PrefixView"
				
				local t = Instance.new("TextLabel", s)
				t.Name = "PrefixLabel"
				t.BackgroundColor3 = Color3.new(34/255,34/255,34/255)
				t.BackgroundTransparency = 0.5
				t.BorderSizePixel = 0
				t.Position = UDim2.new(0.4,0,0.45,0)
				t.Size = UDim2.new(0.2,0,0.1,0)
				t.ZIndex = 9
				t.TextColor3 = Color3.new(1,1,1)
				t.TextScaled = true
				t.TextStrokeTransparency = 0.5
				
				local MyPrefix = plr.Skel_Prefix.Value
				t.Text = MyPrefix
				
				if MyPrefix == "" then
					t.Text = "No prefix"
				end
				
				game:GetService("Debris"):AddItem(s, 3)
			end
		end
	end
	
	if plr:FindFirstChild("Skel_Prefix") then
		local AddToLogs = true
		local RunCommands = true
		local CommandNotification = nil
		
		local prefix = plr.Skel_Prefix.Value
		
		if #prefix > 0 then
			if msg:sub(1, #prefix):lower() == prefix then
				msg = msg:sub(#prefix+1)
			else
				RunCommands = false
			end
		end
		
		if msg:sub(1, 6):lower() == "speed " then msg = "walkspeed "..msg:sub(7) end
		
		local RawMsg = msg
		msg = msg:lower()
		
		if RunCommands then
			if msg == "cmds" or msg == "commands" or msg == "commandlist" then
				if plr:FindFirstChild("PlayerGui") then
					if plr.PlayerGui:FindFirstChild("Skel_InfoGui") then
						plr.PlayerGui.Skel_InfoGui:Destroy()
					end
					
					local MyPrefix = plr.Skel_Prefix.Value
					
					local rList = {"Raw Commands"}
					local pList = {"Public Commands"}
					local aList = {"Admin Commands"}
					local sList = {"Super Admin Commands"}
					local uList = {"Ultra Admin Commands"}
					local oList = {"Owner Commands"}
					
					for i, v in pairs(RawCmds) do
						table.insert(rList, v)
					end
					
					for i, v in pairs(PublicCmds) do
						table.insert(pList, MyPrefix..v)
					end
					
					for i, v in pairs(AdminCmds) do
						table.insert(aList, MyPrefix..v)
					end
					
					for i, v in pairs(SuperCmds) do
						table.insert(sList, MyPrefix..v)
					end
					
					for i, v in pairs(UltraCmds) do
						table.insert(uList, MyPrefix..v)
					end
					
					for i, v in pairs(OwnerCmds) do
						table.insert(oList, MyPrefix..v)
					end
					
					local s = Instance.new("ScreenGui", plr.PlayerGui)
					s.Name = "Skel_InfoGui"
					InfoGUI(s, "Commands", {rList,pList,aList,sList,uList,oList})
				end
			elseif msg == "prefix" or msg == "changeprefix" then
				AddToLogs = false
				
				if plr:FindFirstChild("PlayerGui") and not plr.PlayerGui:FindFirstChild("Skel_PrefixStartup") then
					local gui = script.Skel_Storage.Skel_PrefixStartup:Clone()
					gui.Parent = plr.PlayerGui
				end
			elseif msg == "color" or msg == "colorchange" or msg == "changecolor" or msg == "changesyscolor" or msg == "changesystemcolor" then
				AddToLogs = false
				
				if plr:FindFirstChild("PlayerGui") and not plr.PlayerGui:FindFirstChild("Skel_SCStartup") then
					local gui = script.Skel_Storage.Skel_SCStartup:Clone()
					gui.Parent = plr.PlayerGui
				end
			end
		end
		
		if GetAdminLevel(plr) >= 1 and RunCommands then
			if msg == "clean" then
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v:IsA("Hat") or v:IsA("Tool") then
						v:Destroy()
					end
				end
			elseif msg == "clear" then
				for i, v in pairs(ScriptDebris) do
					v:Destroy()
				end
				for i = #ScriptDebris, 1, -1 do
					table.remove(ScriptDebris, i)
				end
			elseif msg == "fix" then
				DiscoOn = false
				game:GetService("Lighting").Ambient = Skel_Ambient
				game:GetService("Lighting").Brightness = Skel_Brightness
				game:GetService("Lighting").GlobalShadows = Skel_GlobalShadows
				game:GetService("Lighting").Outlines = Skel_Outlines
				game:GetService("Lighting").TimeOfDay = Skel_TimeOfDay
				game:GetService("Lighting").FogColor = Skel_FogColor
				game:GetService("Lighting").FogEnd = Skel_FogEnd
				game:GetService("Lighting").FogStart = Skel_FogStart
			elseif msg:sub(1, 2) == "n " then
				if msg:len() > 2 then
					local NotificationMessage = RawMsg:sub(3)
					for i, v in pairs(game.Players:GetPlayers()) do
						coroutine.resume(coroutine.create(function()
							local NotificationMessage = game:GetService("Chat"):FilterStringAsync(NotificationMessage, v)
							GenerateNotification(v, plr.Name, NotificationMessage, nil, nil, CharacterThumbnailPrefix..plr.Name)
						end))
					end
				end
			elseif msg:sub(1, 3) == "sn " then
				if msg:len() > 3 then
					local NotificationMessage = RawMsg:sub(4)
					for i, v in pairs(game.Players:GetPlayers()) do
						coroutine.resume(coroutine.create(function()
							local NotificationMessage = game:GetService("Chat"):FilterStringForPlayerAsync(NotificationMessage, v)
							GenerateNotification(v, "System Message", NotificationMessage)
						end))
					end
				end
			elseif msg:sub(1, 2) == "m " then
				if msg:len() > 2 then
					local SM_Message = RawMsg:sub(3)
					for i, v in pairs(game.Players:GetPlayers()) do
						coroutine.resume(coroutine.create(function()
							local SM_Message = game:GetService("Chat"):FilterStringForBroadcast(SM_Message, v)
							ScreenMessage(v, plr.Name, SM_Message)
						end))
					end
				end
			elseif msg:sub(1, 3) == "pm " then
				AddToLogs = false
				
				local SelectedUsers
				local Space = nil
				
				for i = 4, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(4, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space then
					local gui = script.Skel_Storage.Skel_PM:Clone()
					gui.Interface.Messenger.Value = plr
					gui.Interface.Header.Text = "Private message from "..plr.Name
					gui.Interface.Message.Text = RawMsg:sub(Space+1)
					
					for i, v in pairs(SelectedUsers) do
						if v:FindFirstChild("PlayerGui") then
							local MsgCopy = gui:Clone()
							MsgCopy.Parent = v.PlayerGui
						end
					end
					
					gui:Destroy()
				end
			elseif msg:sub(1, 2) == "h " then
				if msg:len() > 2 then
					local hint = RawMsg:sub(3)
					for i, v in pairs(game.Players:GetPlayers()) do
						coroutine.resume(coroutine.create(function()
							local hint = game:GetService("Chat"):FilterStringForBroadcast(hint, v)
							Hint(hint, plr.Name, v)
						end))
					end
				end
			elseif msg:sub(1, 10) == "countdown " then
				local StartNumber = tonumber(msg:sub(11))
				
				if StartNumber and not CountGoing then
					Countdown(StartNumber)
				end
			elseif msg == "stopcountdown" then
				CountGoing = false
			elseif msg:sub(1, 3) == "sm " then
				if msg:len() > 3 then
					local SM_Message = RawMsg:sub(4)
					for i, v in pairs(game.Players:GetPlayers()) do
						coroutine.resume(coroutine.create(function()
							local SM_Message = game:GetService("Chat"):FilterStringForBroadcast(SM_Message, v)
							ScreenMessage(v, "System Message", SM_Message)
						end))
					end
				end
			elseif msg == "admins" or msg == "adminlist" then
				AddToLogs = false
				
				if plr:FindFirstChild("PlayerGui") then
					if plr.PlayerGui:findFirstChild("Skel_InfoGui") then
						plr.PlayerGui.Skel_InfoGui:Destroy()
					end
					local ScriptCreatorName = {"Script Creator","Skelris"}
					local OwnerName = {"Owner",OwnerName}
					local ListOfUltraAdmins = {"Ultra Admins"}
					local ListOfSuperAdmins = {"Super Admins"}
					local ListOfAdmins = {"Admins"}
					
					for i, v in pairs(ultraadmins) do
						table.insert(ListOfUltraAdmins, v)
					end
					
					for i, v in pairs(superadmins) do
						table.insert(ListOfSuperAdmins, v)
					end
					
					for i, v in pairs(admins) do
						table.insert(ListOfAdmins, v)
					end
					
					local s = Instance.new("ScreenGui", plr.PlayerGui)
					s.Name = "Skel_InfoGui"
					InfoGUI(s, "Admins", {ScriptCreatorName, OwnerName, ListOfUltraAdmins, ListOfSuperAdmins, ListOfAdmins})
				end
			elseif msg == "bans" or msg == "banlist" then
				AddToLogs = false
				
				if plr:FindFirstChild("PlayerGui") then
					if plr.PlayerGui:findFirstChild("Skel_InfoGui") then
						plr.PlayerGui.Skel_InfoGui:Destroy()
					end
					
					local bList = {"Banned Players"}
					
					for i, v in pairs(banlist) do
						table.insert(bList, v)
					end
					
					local s = Instance.new("ScreenGui", plr.PlayerGui)
					s.Name = "Skel_InfoGui"
					InfoGUI(s, "Banlist", {bList})
				end
			elseif msg == "logs" or msg == "cmdlogs" or msg == "commandlogs" then
				AddToLogs = false
				
				if plr:FindFirstChild("PlayerGui") then
					if plr.PlayerGui:FindFirstChild("Skel_InfoGui") then
						plr.PlayerGui.Skel_InfoGui:Destroy()
					end
					
					local lList = {"Logs"}
						
					for i, v in pairs(CommandLogs) do
						table.insert(lList, v[1]..": "..v[2])
					end
					
					local s = Instance.new("ScreenGui", plr.PlayerGui)
					s.Name = "Skel_InfoGui"
					InfoGUI(s, "Command Logs", {lList})
				end
			elseif msg == "tools" then
				AddToLogs = false
				
				if plr:FindFirstChild("PlayerGui") then
					if plr.PlayerGui:FindFirstChild("Skel_InfoGui") then
						plr.PlayerGui.Skel_InfoGui:Destroy()
					end
					
					local tList = {"Tools"}
					
					for i, v in pairs(game:GetService("ServerStorage"):GetChildren()) do
						if v:IsA("Tool") or v:IsA("HopperBin") then
							table.insert(tList, v.Name)
						end
					end
					
					local s = Instance.new("ScreenGui", plr.PlayerGui)
					s.Name = "Skel_InfoGui"
					InfoGUI(s, "Tools", {tList})
				end
			elseif msg:sub(1, 5) == "time " then
				local InputTime = msg:sub(6)
				if tonumber(InputTime) then
					game:GetService("Lighting"):SetMinutesAfterMidnight(InputTime*60)
				end
			elseif msg:sub(1, 11) == "brightness " then
				local Num = tonumber(msg:sub(12))
				
				if Num then
					game:GetService("Lighting").Brightness = Num
				end
			elseif msg:sub(1, 8) == "ambient " then
				local Space1 = nil
				local Space2 = nil
				local Num1 = nil
				local Num2 = nil
				local Num3 = nil
				for i = 9, msg:len() do
					if msg:sub(i, i) == " " then
						Space1 = i
						Num1 = msg:sub(9, Space1-1)
						break
					end
				end
				if tonumber(Num1) then
					for i = Space1+1, msg:len() do
						if msg:sub(i, i) == " " then
							Space2 = i
							Num2 = msg:sub(Space1+1, Space2-1)
							break
						end
					end
					if tonumber(Num2) then
						Num3 = msg:sub(Space2+1)
						if tonumber(Num3) then
							game:GetService("Lighting").Ambient = Color3.new(Num1/255, Num2/255, Num3/255)
						end
					end
				end
			elseif msg:sub(1, 9) == "fogcolor " then
				coroutine.resume(coroutine.create(function()
					local Space1 = nil
					local Space2 = nil
					local Num1 = nil
					local Num2 = nil
					local Num3 = nil
					for i = 10, msg:len() do
						if msg:sub(i, i) == " " then
							Space1 = i
							Num1 = msg:sub(10, Space1-1)
							break
						end
					end
					if tonumber(Num1) then
						for i = Space1+1, msg:len() do
							if msg:sub(i, i) == " " then
								Space2 = i
								Num2 = msg:sub(Space1+1, Space2-1)
								break
							end
						end
						if tonumber(Num2) then
							Num3 = msg:sub(Space2+1)
							if tonumber(Num3) then
								game:GetService("Lighting").FogColor = Color3.new(Num1/255, Num2/255, Num3/255)
							end
						end
					end
				end))
			elseif msg:sub(1, 7) == "fogend " then
				local Num = tonumber(msg:sub(8))
				
				if Num then
					game:GetService("Lighting").FogEnd = Num
				end
			elseif msg:sub(1, 9) == "fogstart " then
				local Num = tonumber(msg:sub(10))
				
				if Num then
					game:GetService("Lighting").FogStart = Num
				end
			elseif msg == "disco" and FunCommands then
				local CurAmbient = game:GetService("Lighting").Ambient
				while wait(0.35) do
					if DiscoOn == false then
						if game:GetService("Lighting").Ambient ~= Skel_Ambient then
							game:GetService("Lighting").Ambient = Skel_Ambient
						end
						break
					end
					local Num1 = math.random(1, 255)
					local Num2 = math.random(1, 255)
					local Num3 = math.random(1, 255)
					game:GetService("Lighting").Ambient = Color3.new(Num1/255, Num2/255, Num3/255)
				end
			elseif msg:sub(1):lower() == "undisco" and FunCommands then
				DiscoOn = false
			elseif msg:sub(1, 5) == "kill " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						local DoKill = true
						
						if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
							DoKill = false
						end
						
						if DoKill then
							if v.Character then
								for u, c in pairs(v.Character:GetChildren()) do
									if c:IsA("Humanoid") then
										c.Health = 0
									end
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 8) == "explode " then
				local SelectedUsers = NameScan(msg:sub(9), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						local DoExplode = true
						
						if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
							DoExplode = false
						end
						
						if DoExplode then
							if v.Character and v.Character:FindFirstChild("Torso") then
								local e = Instance.new("Explosion", v.Character.Torso)
								e.Position = v.Character.Torso.Position
							end
						end
					end))
				end
			elseif msg:sub(1, 8) == "respawn " then
				local SelectedUsers = NameScan(msg:sub(9), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						local DoRespawn = true
						
						if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
							DoRespawn = false
						end
						
						if DoRespawn then
							v:LoadCharacter()
						end
					end))
				end
			elseif msg:sub(1, 5) == "heal " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								coroutine.resume(coroutine.create(function()
									if c:IsA("Humanoid") then
										c.Health = c.MaxHealth
									end
								end))
							end
						end
					end))
				end
			elseif msg:sub(1, 7) == "damage " then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 8, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(8, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space then
					local DamageNum = tonumber(msg:sub(Space+1))
					
					if DamageNum then
						for i, v in pairs(SelectedUsers) do
							coroutine.resume(coroutine.create(function()
								if v.Character then
									local DoDamage = true
									
									if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
										DoDamage = false
									end
									
									if DoDamage then
										for u, c in pairs(v.Character:GetChildren()) do
											coroutine.resume(coroutine.create(function()
												if c:IsA("Humanoid") then
													local CurHealth = c.Health
													c.Health = CurHealth - DamageNum
												end
											end))
										end
									end
								end
							end))
						end
					end
				end
			elseif msg:sub(1, 3) == "ff " then
				local SelectedUsers = NameScan(msg:sub(4), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							Instance.new("ForceField", v.Character)
						end
					end))
				end
			elseif msg:sub(1, 5) == "unff " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						local DoUnff = true
						
						if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
							DoUnff = false
						end
						
						if DoUnff then
							if v.Character then
								if v.Character:FindFirstChild("ForceField") ~= nil then
									local frcfld = v.Character:GetChildren()
									for i, v in pairs(frcfld) do
										if v.ClassName == "ForceField" then
											v:Destroy()
										end
									end
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 4) == "god " then
				local SelectedUsers = NameScan(msg:sub(5), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							local CharHumanoid = nil
							
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Humanoid") then
									CharHumanoid = c
									break
								end
							end
							
							if CharHumanoid then
								CharHumanoid.MaxHealth = math.huge
								CharHumanoid.Health = 1e1
							end
						end
					end))
				end
			elseif msg:sub(1, 6) == "ungod " then
				local SelectedUsers = NameScan(msg:sub(7), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						local DoUngod = true
						
						if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
							DoUngod = false
						end
						
						if DoUngod then
							if v.Character then
								local CharHumanoid = nil
								
								for u, c in pairs(v.Character:GetChildren()) do
									if c:IsA("Humanoid") then
										CharHumanoid = c
										break
									end
								end
								
								if CharHumanoid then
									CharHumanoid.MaxHealth = 100
									CharHumanoid.Health = 100
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 7) == "freeze " then
				local SaidNames = NameScan(msg:sub(8), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SaidNames) do
					coroutine.resume(coroutine.create(function()
						if v.Character and v.Character:findFirstChild("Humanoid") then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Part") then
									c.Anchored = true
								end
							end
							v.Character.Humanoid.WalkSpeed = 0
						end
					end))
				end
			elseif msg:sub(1, 5) == "thaw " then
				local SaidNames = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SaidNames) do
					coroutine.resume(coroutine.create(function()
						if v.Character and v.Character:findFirstChild("Humanoid") then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Part") then
									c.Anchored = true
								end
							end
							v.Character.Humanoid.WalkSpeed = 16
						end
					end))
				end
			elseif msg:sub(1, 6) == "clone " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(7), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							v.Character.Archivable = true
							local cl = v.Character:Clone()
							table.insert(ScriptDebris, cl)
							cl:MakeJoints()
							cl.Parent = game.Workspace
							cl:MoveTo(v.Character:GetModelCFrame().p)
							v.Character.Archivable = false
						end
					end))
				end
			elseif msg:sub(1, 6) == "music " and FunCommands then
				if tonumber(msg:sub(7)) then
					if game.Workspace:FindFirstChild("Skel_Sound") then
						game.Workspace.Skel_Sound:Stop()
						game.Workspace.Skel_Sound:Destroy()
					end
					local MusID = tonumber(msg:sub(7))
					local snd = Instance.new("Sound", game.Workspace)
					snd.Name = "Skel_Sound"
					snd.Pitch = 1
					snd.Volume = 1
					snd.Archivable = false
					snd.Looped = true
					snd.SoundId = "http://www.roblox.com/asset/?id="..MusID
					repeat snd:Play() wait(0.5) until snd.IsPlaying
				end
			elseif (msg == "musicstop" or msg == "stopmusic" or msg == "musicoff") and FunCommands then
				if game.Workspace:FindFirstChild("Skel_Sound") then
					game.Workspace.Skel_Sound:Stop()
					game.Workspace.Skel_Sound:Destroy()
				end
			elseif msg:sub(1, 5) == "team " then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 6, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(6, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space then
					local team = NameScan(msg:sub(Space+1), game:GetService("Teams"):GetChildren(), "Teams", plr)[1]
					
					for i, v in pairs(team) do
						print(v.Name)
					end
					
					if #team > 0 then
						local ChosenTeamColor = nil
						for i, v in pairs(team) do
							if v:IsA("Team") then
								ChosenTeamColor = v.TeamColor
								break
							end
						end
						
						if ChosenTeamColor then
							for i, v in pairs(SelectedUsers) do
								v.TeamColor = ChosenTeamColor
							end
						end
					end
				end
			elseif msg:sub(1, 5) == "give " then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 6, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(6, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space ~= nil then
					local tools = {}
					
					for i, v in pairs(game:GetService("ServerStorage"):GetChildren()) do
						if v:IsA("Tool") or v:IsA("HopperBin") then
							table.insert(tools, v)
						end
					end
					
					local SelectedTools = NameScan(msg:sub(Space+1), tools, "Tools", plr)[1]
					
					for i, v in pairs(SelectedUsers) do
						coroutine.resume(coroutine.create(function()
							if v:FindFirstChild("Backpack") then
								for u, c in pairs(SelectedTools) do
									local NewTool = c:Clone()
									NewTool.Parent = v.Backpack
								end
							end
						end))
					end 
				end
			elseif msg:sub(1, 5) == "take " then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 6, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(6, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space ~= nil then
					if msg:sub(Space+1) == "all" then
						for i, v in pairs(SelectedUsers) do
							coroutine.resume(coroutine.create(function()
								local DoTake = true
								
								if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
									DoTake = false
								end
								
								if DoTake then
									if v.Character then
										for u, c in pairs(v.Character:GetChildren()) do
											if c:IsA("Humanoid") then
												c:UnequipTools()
												break
											end
										end
									end
									if v:FindFirstChild("Backpack") then
										for u, c in pairs(v.Backpack:GetChildren()) do
											if c:IsA("Tool") or c:IsA("HopperBin") then
												c:Destroy()
											end
										end
									end
								end
							end))
						end
					else
						local tools = NameScan(msg:sub(Space+1), {}, "Tools", plr)[2]
						
						for i, v in pairs(SelectedUsers) do
							coroutine.resume(coroutine.create(function()
								local DoTake = true
								
								if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
									DoTake = false
								end
								
								if DoTake then
									if v.Character then
										local Humanoid = nil
										for u, c in pairs(v.Character:GetChildren()) do
											if c:IsA("Humanoid") then
												Humanoid = c
												break
											end
										end
										
										if Humanoid then
											for u, c in pairs(v.Character:GetChildren()) do
												for y, x in pairs(tools) do
													if c.Name:sub(1, x:len()):lower() == x:lower() then
														Humanoid:UnequipTools()
														break
													end
												end
											end
										end
									end
									if v:FindFirstChild("Backpack") then
										for u, c in pairs(v.Backpack:GetChildren()) do
											coroutine.resume(coroutine.create(function()
												if c:IsA("Tool") or c:IsA("HopperBin") then
													for y, x in pairs(tools) do
														if c.Name:sub(1, x:len()):lower() == x:lower() then
															c:Destroy()
														end
													end
												end
											end))
										end
									end
								end
							end))
						end
					end
				end
			elseif msg:sub(1, 12) == "startergive " then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 13, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(13, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space ~= nil then
					local tools = {}
					
					for i, v in pairs(game:GetService("ServerStorage"):GetChildren()) do
						if v:IsA("Tool") or v:IsA("HopperBin") then
							table.insert(tools, v)
						end
					end
					
					local SelectedTools = NameScan(msg:sub(Space+1), tools, "Tools", plr)[1]
					
					for i, v in pairs(SelectedUsers) do
						coroutine.resume(coroutine.create(function()
							if v:FindFirstChild("StarterGear") then
								for u, c in pairs(SelectedTools) do
									local NewTool = c:Clone()
									NewTool.Parent = v.StarterGear
								end
							end
						end))
					end 
				end
			elseif msg:sub(1, 12) == "startertake " then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 13, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(13, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space ~= nil then
					if msg:sub(Space+1) == "all" then
						for i, v in pairs(SelectedUsers) do
							coroutine.resume(coroutine.create(function()
								local DoTake = true
								
								if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
									DoTake = false
								end
								
								if DoTake then
									if v:FindFirstChild("StarterGear") then
										for u, c in pairs(v.StarterGear:GetChildren()) do
											if c:IsA("Tool") or c:IsA("HopperBin") then
												c:Destroy()
											end
										end
									end
								end
							end))
						end
					else
						local tools = NameScan(msg:sub(Space+1), {}, "Tools", plr)[2]
						
						for i, v in pairs(SelectedUsers) do
							coroutine.resume(coroutine.create(function()
								local DoTake = true
								
								if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
									DoTake = false
								end
								
								if DoTake then
									if v:FindFirstChild("StarterGear") then
										for u, c in pairs(v.StarterGear:GetChildren()) do
											coroutine.resume(coroutine.create(function()
												if c:IsA("Tool") or c:IsA("HopperBin") then
													for y, x in pairs(tools) do
														if c.Name:sub(1, x:len()):lower() == x:lower() then
															c:Destroy()
														end
													end
												end
											end))
										end
									end
								end
							end))
						end
					end
				end
			elseif msg:sub(1, 10) == "viewtools " then
				AddToLogs = false
				
				local SelectedUsers = NameScan(msg:sub(11), game.Players:GetPlayers(), "Players", plr)[1]
				
				if #SelectedUsers > 0 then
					local User = SelectedUsers[1]
					
					if User:FindFirstChild("Backpack") then
						if plr:FindFirstChild("PlayerGui") then
							if plr.PlayerGui:FindFirstChild("Skel_InfoGui") then
								plr.PlayerGui.Skel_InfoGui:Destroy()
							end
							
							local tList = {User.Name.."'s Tools"}
							
							for i, v in pairs(User.Backpack:GetChildren()) do
								if v:IsA("Tool") or v:IsA("HopperBin") then
									table.insert(tList, v.Name)
								end
							end
							
							local s = Instance.new("ScreenGui", plr.PlayerGui)
							s.Name = "Skel_InfoGui"
							InfoGUI(s, User.Name.."'s Tools", {tList})
						end
					end
				end
			elseif msg:sub(1, 17) == "viewstartertools " then
				AddToLogs = false
				
				local SelectedUsers = NameScan(msg:sub(18), game.Players:GetPlayers(), "Players", plr)[1]
				
				if #SelectedUsers > 0 then
					local User = SelectedUsers[1]
					
					if User:FindFirstChild("StarterGear") then
						if plr:FindFirstChild("PlayerGui") then
							if plr.PlayerGui:FindFirstChild("Skel_InfoGui") then
								plr.PlayerGui.Skel_InfoGui:Destroy()
							end
							
							local tList = {User.Name.."'s Starter Tools"}
							
							for i, v in pairs(User.StarterGear:GetChildren()) do
								if v:IsA("Tool") or v:IsA("HopperBin") then
									table.insert(tList, v.Name)
								end
							end
							
							local s = Instance.new("ScreenGui", plr.PlayerGui)
							s.Name = "Skel_InfoGui"
							InfoGUI(s, User.Name.."'s Starter Tools", {tList})
						end
					end
				end
			elseif msg:sub(1, 7) == "btools " then
				local SelectedUsers = NameScan(msg:sub(8), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v:FindFirstChild("Backpack") ~= nil then
							Instance.new("HopperBin", v.Backpack).BinType = "GameTool"
							Instance.new("HopperBin", v.Backpack).BinType = "Clone"
							Instance.new("HopperBin", v.Backpack).BinType = "Hammer"
						end
					end))
				end
			elseif msg:sub(1, 11) == "cleartools " then
				local SelectedUsers = NameScan(msg:sub(12), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						local DoClear = true
						
						if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
							DoClear = false
						end
						
						if DoClear then
							if v.Character then
								for u, c in pairs(v.Character:GetChildren()) do
									if c:IsA("Humanoid") then
										c:UnequipTools()
									end
								end
							end
							
							if v:FindFirstChild("Backpack") ~= nil then
								for u, c in pairs(v.Backpack:GetChildren()) do
									if c:IsA("Tool") or c:IsA("HopperBin") then
										c:Destroy()
									end
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 10) == "walkspeed " then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 11, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(11, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space then
					local speed = tonumber(msg:sub(Space+1))
					
					if speed then
						for i, v in pairs(SelectedUsers) do
							coroutine.resume(coroutine.create(function()
								if v.Character then
									for u, c in pairs(v.Character:GetChildren()) do
										if c:IsA("Humanoid") then
											c.WalkSpeed = speed
										end
									end
								end
							end))
						end
					end
				end
			elseif msg:sub(1, 9) == "highgrav " then
				local SelectedUsers = NameScan(msg:sub(10), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character and v.Character:FindFirstChild("Torso") then
							if v.Character.Torso:FindFirstChild("Skel_Force") then
								v.Character.Torso.Skel_Force:Destroy()
							end
							local b = Instance.new("BodyForce")
							b.Name = "Skel_Force"
							b.force = Vector3.new(0,0,0)
							
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Part") then
									b.force = b.force + Vector3.new(0,(c:GetMass()*196.2)*-1,0)
								elseif c:IsA("Hat") then
									if c:FindFirstChild("Handle") then
										b.force = b.force + Vector3.new(0,(c.Handle:GetMass()*196.2)*-1,0)
									end
								end
							end
							
							b.Parent = v.Character.Torso
						end
					end))
				end
			elseif msg:sub(1, 5) == "grav " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character and v.Character:FindFirstChild("Torso") then
							if v.Character.Torso:FindFirstChild("Skel_Force") then
								v.Character.Torso.Skel_Force:Destroy()
							end
						end
					end))
				end
			elseif msg:sub(1, 8) == "lowgrav " then
				local SelectedUsers = NameScan(msg:sub(9), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character and v.Character:FindFirstChild("Torso") then
							if v.Character.Torso:FindFirstChild("Skel_Force") then
								v.Character.Torso.Skel_Force:Destroy()
							end
							local b = Instance.new("BodyForce")
							b.Name = "Skel_Force"
							b.force = Vector3.new(0,0,0)
							
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Part") then
									b.force = b.force + Vector3.new(0,c:GetMass()*140,0)
								elseif c:IsA("Hat") then
									if c:FindFirstChild("Handle") then
										b.force = b.force + Vector3.new(0,c.Handle:GetMass()*140,0)
									end
								end
							end
							
							b.Parent = v.Character.Torso
						end
					end))
				end
			elseif msg:sub(1, 7) == "nograv " then
				local SelectedUsers = NameScan(msg:sub(8), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character and v.Character:FindFirstChild("Torso") then
							if v.Character.Torso:FindFirstChild("Skel_Force") then
								v.Character.Torso.Skel_Force:Destroy()
							end
							local b = Instance.new("BodyForce")
							b.Name = "Skel_Force"
							b.force = Vector3.new(0,0,0)
							
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Part") then
									b.force = b.force + Vector3.new(0,c:GetMass()*196.25,0)
								elseif c:IsA("Hat") then
									if c:FindFirstChild("Handle") then
										b.force = b.force + Vector3.new(0,c.Handle:GetMass()*196.25,0)
									end
								end
							end
							
							b.Parent = v.Character.Torso
						end
					end))
				end
			elseif msg:sub(1, 8) == "setgrav " then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 9, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(9, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space then
					for i, v in pairs(SelectedUsers) do
						coroutine.resume(coroutine.create(function()
							local grav = tonumber(msg:sub(Space+1))
							
							if grav then
								if v.Character and v.Character:FindFirstChild("Torso") then
									if v.Character.Torso:FindFirstChild("Skel_Force") then
										v.Character.Torso.Skel_Force:Destroy()
									end
									
									local b = Instance.new("BodyForce")
									b.Name = "Skel_Force"
									b.force = Vector3.new(0,0,0)
									
									for u, c in pairs(v.Character:GetChildren()) do
										if c:IsA("Part") then
											b.force = b.force + Vector3.new(0,c:GetMass()*-grav,0)
										elseif c:IsA("Hat") then
											if c:findFirstChild("Handle") then
												b.force = b.force + Vector3.new(0,c.Handle:GetMass()*-grav,0)
											end
										end
									end
									
									b.Parent = v.Character.Torso
								end
							end
						end))
					end
				end
			elseif msg:sub(1, 6) == "fling " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(7), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						local DoFling = true
						
						if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
							DoFling = false
						end
						
						if DoFling then
							if v.Character and v.Character:FindFirstChild("Torso") and v.Character:FindFirstChild("Humanoid") then
								local b = Instance.new("BodyForce")
								b.Name = "Skel_Fling"
								b.force = Vector3.new(0,0,0)
								
								local Num1
								local Num2
								
								repeat Num1 = math.random(-9999, 9999) until math.abs(Num1) >= 5555
								repeat Num2 = math.random(-9999, 9999) until math.abs(Num2) >= 5555
								
								v.Character.Humanoid.Sit = true
								v.Character.Torso.Velocity = Vector3.new(0,0,0)
								b.force = Vector3.new(Num1*4,9999*5,Num2*4)
								
								game:GetService("Debris"):AddItem(b, 0.1)
								
								b.Parent = v.Character.Torso
							end
						end
					end))
				end
			elseif msg:sub(1, 5) == "name " and FunCommands then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 6, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(6, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space then
					local NameChange = RawMsg:sub(Space+1)
					
					for i, v in pairs(SelectedUsers) do
						coroutine.resume(coroutine.create(function()
							if v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Torso") then
								local CurTrans = nil
								for u, c in pairs(v.Character:GetChildren()) do
									if c:FindFirstChild("tag") then
										CurTrans = c.Head.Transparency
										c:Destroy()
									end
								end
								local chr = v.Character
								local fm = Instance.new("Model", chr)
								local fh = Instance.new("Humanoid", fm)
								fh.Name = "tag"
								fh.Health = 0
								fh.MaxHealth = 0
								fh.WalkSpeed = 0
								if CurTrans ~= nil then
									chr.Head.Transparency = CurTrans
								end
								local cp = chr.Head:Clone()
								chr.Head.Transparency = 1
								cp.Parent = fm
								local HeadPlace = Instance.new("Weld", cp)
								HeadPlace.Part0 = cp
								HeadPlace.Part1 = chr.Head
								HeadPlace.C0 = chr.Head.CFrame
								HeadPlace.C1 = chr.Head.CFrame
								fm.Name = NameChange
							end
						end))
					end
				end
			elseif msg:sub(1, 7) == "unname " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(8), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							local chr = v.Character
							if chr:FindFirstChild("Head") then
								local CurTrans = nil
								for u, c in pairs(chr:GetChildren()) do
									if c:FindFirstChild("tag") then
										CurTrans = c.Head.Transparency
										c:Destroy()
									end
								end
								if CurTrans ~= nil then
									chr.Head.Transparency = CurTrans
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 3) == "tp " then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 4, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(4, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space ~= nil then
					local ToName = NameScan(msg:sub(Space+1), game.Players:GetPlayers(), "Players", plr)[1]
					if #ToName >= 1 then
						local TpTo = ToName[1]
						for i, v in pairs(SelectedUsers) do
							coroutine.resume(coroutine.create(function()
								if v.Character and TpTo.Character then
									if v.Character:FindFirstChild("Torso") and TpTo.Character:FindFirstChild("Torso") then
										if v.Character:FindFirstChild("Humanoid") then
											v.Character.Humanoid.Jump = true
											wait()
											v.Character.Torso.CFrame = TpTo.Character.Torso.CFrame + Vector3.new(math.random(-2,2),0,math.random(-2,2))
										end
									end
								end
							end))
						end
					end
				end
			elseif msg == "saveteleport" or msg == "savetp" then
				if not plr:FindFirstChild("Skel_TeleportSave") then
					local c = Instance.new("CFrameValue", plr)
					c.Name = "Skel_TeleportSave"
				end
				
				if plr.Character then
					if plr.Character:FindFirstChild("Torso") then
						local pos = plr.Character.Torso.CFrame
						plr.Skel_TeleportSave.Value = pos
					end
				end
			elseif msg == "loadteleport" or msg == "loadtp" then
				if plr:FindFirstChild("Skel_TeleportSave") and plr.Character then
					if plr.Character:FindFirstChild("Torso") then
						local pos = plr.Skel_TeleportSave.Value
						plr.Character.Torso.CFrame = pos
					end
				end
			elseif msg:sub(1, 5) == "swap " then
				local NameOne = nil
				local NameTwo = nil
				local Space = nil
				
				for i = 6, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						NameOne = NameScan(msg:sub(6, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space ~= nil then
					local NameTwo = NameScan(msg:sub(Space+1), game.Players:GetPlayers(), "Players", plr)[1]
					if #NameOne == 1 and #NameTwo == 1 then
						local FirstName = NameOne[1]
						local SecondName = NameTwo[1]
						if FirstName.Character and FirstName.Character:FindFirstChild("Torso") and SecondName.Character and SecondName.Character:FindFirstChild("Torso") then
							if FirstName.Character:FindFirstChild("Humanoid") and SecondName.Character:FindFirstChild("Humanoid") then
								FirstName.Character.Humanoid.Jump = true
								SecondName.Character.Humanoid.Jump = true
								wait()
								local PosOne = FirstName.Character.Torso.CFrame
								local PosTwo = SecondName.Character.Torso.CFrame
								FirstName.Character.Torso.CFrame = PosTwo
								SecondName.Character.Torso.CFrame = PosOne
							end
						end
					end
				end
			elseif msg:sub(1, 4) == "sit " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(5), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							if v.Character:FindFirstChild("Torso") then
								local bg = Instance.new("BodyGyro", v.Character.Torso)
								game:GetService("Debris"):AddItem(bg, 5)
							end
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Humanoid") then
									c.Sit = true
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 5) == "jump " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Humanoid") then
									c.Jump = true
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 5) == "trip " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character and v.Character:FindFirstChild("Torso") then
							v.Character.Torso.CFrame = v.Character.Torso.CFrame * CFrame.Angles(0,0,math.rad(180))
						end
					end))
				end
			elseif msg:sub(1, 5) == "stun " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Humanoid") then
									c.PlatformStand = true
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 7) == "unstun " then
				local SelectedUsers = NameScan(msg:sub(8), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Humanoid") then
									c.PlatformStand = false
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 7) == "noclip " then
				local SelectedUsers = NameScan(msg:sub(8), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						repeat wait() until v.Character and script:FindFirstChild("Skel_ScriptStorage") and script.Skel_ScriptStorage:FindFirstChild("Skel_NoClip")
						if not v.Character:FindFirstChild("Skel_NoClip") then
							local s = script.Skel_ScriptStorage.Skel_NoClip:Clone()
							s.Parent = v.Character
							s.Disabled = false
						end
					end))
				end
			elseif msg:sub(1, 5) == "clip " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						repeat wait() until v.Character and v.Character:FindFirstChild("Torso") and v.Character:FindFirstChild("Humanoid")
						if v.Character:FindFirstChild("Skel_NoClip") then
							v.Character.Skel_NoClip:Destroy()
							v.Character.Torso.Anchored = false
							wait(0.1)
							v.Character.Humanoid.PlatformStand = false
						end
					end))
				end
			elseif msg:sub(1, 4) == "hat " and FunCommands then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 5, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(5, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space then
					coroutine.resume(coroutine.create(function()
						for i, v in pairs(SelectedUsers) do
							if v.Character then
								if tonumber(msg:sub(Space+1)) then
									local hat = game:GetService("InsertService"):LoadAsset(tonumber(msg:sub(Space+1)))
									for u, c in pairs(hat:GetChildren()) do
										if c:IsA("Hat") then
											c.Parent = v.Character
										end
									end
									hat:Destroy()
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 5) == "gear " and FunCommands then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 6, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(6, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space then
					for i, v in pairs(SelectedUsers) do
						coroutine.resume(coroutine.create(function()
							if v:FindFirstChild("Backpack") then
								if tonumber(msg:sub(Space+1)) then
									local gear = game:GetService("InsertService"):LoadAsset(tonumber(msg:sub(Space+1)))
									for u, c in pairs(gear:GetChildren()) do
										if c:IsA("Tool") then
											c.Parent = v.Backpack
										end
									end
									gear:Destroy()
								end
							end
						end))
					end
				end
			elseif msg:sub(1, 9) == "sparkles " then
				local SelectedUsers = NameScan(msg:sub(10), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						GiveParticles("Sparkles", v)
					end))
				end
			elseif msg:sub(1, 11) == "unsparkles " then
				local SelectedUsers = NameScan(msg:sub(12), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						TakeParticles("Sparkles", v)
					end))
				end
			elseif msg:sub(1, 6) == "smoke " then
				local SelectedUsers = NameScan(msg:sub(7), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						GiveParticles("Smoke", v)
					end))
				end
			elseif msg:sub(1, 8) == "unsmoke " then
				local SelectedUsers = NameScan(msg:sub(9), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						TakeParticles("Smoke", v)
					end))
				end
			elseif msg:sub(1, 5) == "fire " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						GiveParticles("Fire", v)
					end))
				end
			elseif msg:sub(1, 7) == "unfire " then
				local SelectedUsers = NameScan(msg:sub(8), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						TakeParticles("Fire", v)
					end))
				end
			elseif msg:sub(1, 6) == "light " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(7), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							if v.Character:FindFirstChild("Torso") ~= nil then
								local pl = Instance.new("PointLight", v.Character.Torso)
								pl.Brightness = 100
								pl.Range = 10
							end
						end
					end))
				end
			elseif msg:sub(1, 8) == "unlight " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(9), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						TakeParticles("PointLight", v)
					end))
				end
			elseif msg:sub(1, 5) == "lock " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Part") then
									c.Locked = true
								elseif c:IsA("Hat") and c:FindFirstChild("Handle") then
									c.Handle.Locked = true
								elseif c:IsA("Model") and c:FindFirstChild("tag") and c:FindFirstChild("Head") then
									c.Head.Locked = true
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 7) == "unlock " then
				local SelectedUsers = NameScan(msg:sub(8), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Part") then
									c.Locked = false
								elseif c:IsA("Hat") and c:FindFirstChild("Handle") then
									c.Handle.Locked = false
								elseif c:IsA("Model") and c:FindFirstChild("tag") and c:FindFirstChild("Head") then
									c.Head.Locked = false
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 10) == "invisible " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(11), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Model") then
									if c:findFirstChild("tag") then
										c.Head.Transparency = 1
										if c.Head:findFirstChild("face") then
											c.Head.face.Transparency = 1
										end
									end
								elseif c:IsA("Hat") then
									if c:findFirstChild("Handle") then
										c.Handle.Transparency = 1
									end
								elseif c:IsA("Part") and c.Name ~= "HumanoidRootPart" then
									c.Transparency = 1
									if c:findFirstChild("face") then
										c.face.Transparency = 1
									end
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 8) == "visible " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(9), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Hat") then
									if c:findFirstChild("Handle") then
										c.Handle.Transparency = 0
									end
								elseif c:IsA("Part") and c.Name ~= "HumanoidRootPart" then
									c.Transparency = 0
									if c:findFirstChild("face") then
										c.face.Transparency = 0
									end
								end
							end
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Model") then
									if c:findFirstChild("tag") then
										c.Head.Transparency = 0
										if c.Head:findFirstChild("face") then
											c.Head.face.Transparency = 0
										end
										if v.Character:findFirstChild("Head") then
											v.Character.Head.Transparency = 1
										end
										break
									end
								end
							end	
						end
					end))
				end
			elseif msg:sub(1, 9) == "ghostify " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(10), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Hat") then
									if c:findFirstChild("Handle") then
										c.Handle.Transparency = 0.5
									end
								elseif c:IsA("Part") and c.Name ~= "HumanoidRootPart" then
									c.Transparency = 0.5
									if c:findFirstChild("face") then
										c.face.Transparency = 0.5
									end
								end
							end
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Model") then
									if c:findFirstChild("tag") then
										c.Head.Transparency = 0.5
										if c.Head:findFirstChild("face") then
											c.Head.face.Transparency = 0.5
										end
										if v.Character:findFirstChild("Head") then
											v.Character.Head.Transparency = 1
										end
										break
									end
								end
							end	
						end
					end))
				end
			elseif msg:sub(1, 5) == "char " and FunCommands then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 6, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(6, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space then
					for i, v in pairs(SelectedUsers) do
						coroutine.resume(coroutine.create(function()
							local charID = tonumber(msg:sub(Space+1))
							if charID then
								local pos = nil
								local speed = nil
								local health = nil
								local maxhealth = nil
								local backpacktools = {}
								local holdingtool = nil
								if v.Character and v.Character:findFirstChild("Torso") then
									pos = v.Character.Torso.CFrame
								end
								if v.Character and v.Character:findFirstChild("Humanoid") then
									if v.Character.Humanoid.Health ~= 0 then
										speed = v.Character.Humanoid.WalkSpeed
										health = v.Character.Humanoid.Health
										maxhealth = v.Character.Humanoid.MaxHealth
									end
								end
								if v:findFirstChild("Backpack") then
									for u, c in pairs(v.Backpack:GetChildren()) do
										table.insert(backpacktools, c:Clone())
									end
								end
								if v.Character then
									for u, c in pairs(v.Character:GetChildren()) do
										if c:IsA("Tool") then
											holdingtool = c:Clone()
											break
										end
									end
								end
								v.CharacterAppearance = "http://www.roblox.com/asset/CharacterFetch.ashx?userId="..charID
								v:LoadCharacter()
								if pos ~= nil then
									v.Character.Torso.CFrame = pos
								end
								if (speed and health and maxhealth) ~= nil then
									repeat wait() until v.Character
									repeat wait() until v.Character:findFirstChild("Humanoid")
									v.Character.Humanoid.WalkSpeed = speed
									v.Character.Humanoid.Health = health
									v.Character.Humanoid.MaxHealth = maxhealth
								end
								repeat wait() until v:findFirstChild("Backpack")
								wait(0.5)
								for u, c in pairs(v.Backpack:GetChildren()) do
									c:Destroy()
								end
								for u, c in pairs(backpacktools) do
									c.Parent = v.Backpack
								end
								if holdingtool ~= nil then
									repeat wait() until v.Character
									if v:findFirstChild("Backpack") then
										holdingtool.Parent = v.Backpack
										wait(0.5)
									end
									holdingtool.Parent = v.Character
								end
							end
						end))
					end
				end
			elseif msg:sub(1, 7) == "unchar " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(8), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						local pos = nil
						local speed = nil
						local health = nil
						local maxhealth = nil
						local backpacktools = {}
						local holdingtool = nil
						if v.Character and v.Character:findFirstChild("Torso") then
							pos = v.Character.Torso.CFrame
						end
						if v.Character and v.Character:findFirstChild("Humanoid") then
							if v.Character.Humanoid.Health ~= 0 then
								speed = v.Character.Humanoid.WalkSpeed
								health = v.Character.Humanoid.Health
								maxhealth = v.Character.Humanoid.MaxHealth
							end
						end
						if v:findFirstChild("Backpack") then
							for u, c in pairs(v.Backpack:GetChildren()) do
								table.insert(backpacktools, c:Clone())
							end
						end
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Tool") then
									holdingtool = c:Clone()
									break
								end
							end
						end
						v.CharacterAppearance = "http://www.roblox.com/asset/CharacterFetch.ashx?userId="..v.userId
						v:LoadCharacter()
						if pos ~= nil then
							v.Character.Torso.CFrame = pos
						end
						if (speed and health and maxhealth) ~= nil then
							repeat wait() until v.Character
							repeat wait() until v.Character:findFirstChild("Humanoid")
							v.Character.Humanoid.WalkSpeed = speed
							v.Character.Humanoid.Health = health
							v.Character.Humanoid.MaxHealth = maxhealth
						end
						repeat wait() until v:findFirstChild("Backpack")
						wait(0.5)
						for u, c in pairs(v.Backpack:GetChildren()) do
							c:Destroy()
						end
						for u, c in pairs(backpacktools) do
							c.Parent = v.Backpack
						end
						if holdingtool ~= nil then
							repeat wait() until v.Character
							holdingtool.Parent = v.Character
						end
					end))
				end
			elseif msg:sub(1, 8) == "plrchar " and FunCommands then
				local SelectedUsers = nil
				local Space = nil
				
				for i = 9, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SelectedUsers = NameScan(msg:sub(9, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space then
					local ToName = NameScan(msg:sub(Space+1), game.Players:GetPlayers(), "Players", plr)[1]
					if #ToName >= 1 then
						for i, v in pairs(SelectedUsers) do
							coroutine.resume(coroutine.create(function()
								local charID = ToName[1].userId
								if charID then
									local pos = nil
									local speed = nil
									local health = nil
									local maxhealth = nil
									local backpacktools = {}
									local holdingtool = nil
									if v.Character and v.Character:findFirstChild("Torso") then
										pos = v.Character.Torso.CFrame
									end
									if v.Character and v.Character:findFirstChild("Humanoid") then
										if v.Character.Humanoid.Health ~= 0 then
											speed = v.Character.Humanoid.WalkSpeed
											health = v.Character.Humanoid.Health
											maxhealth = v.Character.Humanoid.MaxHealth
										end
									end
									if v:findFirstChild("Backpack") then
										for u, c in pairs(v.Backpack:GetChildren()) do
											table.insert(backpacktools, c:Clone())
										end
									end
									if v.Character then
										for u, c in pairs(v.Character:GetChildren()) do
											if c:IsA("Tool") then
												holdingtool = c:Clone()
												break
											end
										end
									end
									v.CharacterAppearance = "http://www.roblox.com/asset/CharacterFetch.ashx?userId="..charID
									v:LoadCharacter()
									if pos ~= nil then
										v.Character.Torso.CFrame = pos
									end
									if (speed and health and maxhealth) ~= nil then
										repeat wait() until v.Character
										repeat wait() until v.Character:findFirstChild("Humanoid")
										v.Character.Humanoid.WalkSpeed = speed
										v.Character.Humanoid.Health = health
										v.Character.Humanoid.MaxHealth = maxhealth
									end
									repeat wait() until v:findFirstChild("Backpack")
									wait(0.5)
									for u, c in pairs(v.Backpack:GetChildren()) do
										c:Destroy()
									end
									for u, c in pairs(backpacktools) do
										c.Parent = v.Backpack
									end
									if holdingtool ~= nil then
										repeat wait() until v.Character
										holdingtool.Parent = v.Character
									end
								end
							end))
						end
					end
				end
			elseif msg:sub(1, 11) == "randomchar " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(12), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						local NewID = math.random(1, 80000000)
						local pos = nil
						local speed = nil
						local health = nil
						local maxhealth = nil
						local backpacktools = {}
						local holdingtool = nil
						if v.Character and v.Character:findFirstChild("Torso") then
							pos = v.Character.Torso.CFrame
						end
						if v.Character and v.Character:findFirstChild("Humanoid") then
							if v.Character.Humanoid.Health ~= 0 then
								speed = v.Character.Humanoid.WalkSpeed
								health = v.Character.Humanoid.Health
								maxhealth = v.Character.Humanoid.MaxHealth
							end
						end
						if v:findFirstChild("Backpack") then
							for u, c in pairs(v.Backpack:GetChildren()) do
								table.insert(backpacktools, c:Clone())
							end
						end
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Tool") then
									holdingtool = c:Clone()
									break
								end
							end
						end
						v.CharacterAppearance = "http://www.roblox.com/asset/CharacterFetch.ashx?userId="..NewID
						v:LoadCharacter()
						if pos ~= nil then
							v.Character.Torso.CFrame = pos
						end
						if (speed and health and maxhealth) ~= nil then
							repeat wait() until v.Character
							repeat wait() until v.Character:findFirstChild("Humanoid")
							v.Character.Humanoid.WalkSpeed = speed
							v.Character.Humanoid.Health = health
							v.Character.Humanoid.MaxHealth = maxhealth
						end
						repeat wait() until v:findFirstChild("Backpack")
						wait(0.5)
						for u, c in pairs(v.Backpack:GetChildren()) do
							c:Destroy()
						end
						for u, c in pairs(backpacktools) do
							c.Parent = v.Backpack
						end
						if holdingtool ~= nil then
							repeat wait() until v.Character
							holdingtool.Parent = v.Character
						end
					end))
				end
			elseif msg:sub(1, 11) == "clearlimbs " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(12), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							for u, c in pairs(v.Character:GetChildren()) do
								if c:IsA("Part") and (c.Name:find("Arm") or c.Name:find("Leg")) then
									c:Destroy()
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 7) == "clrapp " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(8), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						v:ClearCharacterAppearance()
						if v.Character:findFirstChild("Shirt Graphic") ~= nil then
							v.Character:findFirstChild("Shirt Graphic"):Destroy()
						end
						if v.Character:findFirstChild("Torso") ~= nil then
							v.Character.Torso:findFirstChild("roblox"):Destroy()
						end
					end))
				end
			elseif msg:sub(1, 8) == "noobify " and FunCommands then
				local SelectedUsers = NameScan(msg:sub(9), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if v.Character then
							v:ClearCharacterAppearance()
							wait()
							for u, c in pairs(v.Character:GetChildren()) do
								if c.Name == "Body Colors" then
									c:Destroy()
								elseif c.Name == "Right Arm" or c.Name == "Left Arm" then
									c.BrickColor = BrickColor.new(24)
								elseif c.Name == "Right Leg" or c.Name == "Left Leg" then
									c.BrickColor = BrickColor.new(119)
								elseif c.Name == "Torso" then
									c.BrickColor = BrickColor.new(23)
									if c:FindFirstChild("roblox") then
										c.roblox:Destroy()
									end
								elseif c.Name == "Head" then
									c.BrickColor = BrickColor.new(24)
									if c:FindFirstChild("face") then
										c.face.Texture = "rbxasset://textures/face.png"
									end
								elseif c.Name == "Shirt Graphic" then
									c:Destroy()
								end
							end
						end
					end))
				end
			end
		end
		
		if GetAdminLevel(plr) >= 2 and RunCommands then
			if msg:sub(1, 6) == "admin " then
				local SelectedUsers = NameScan(msg:sub(7), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						GiveAdmin(v, admins, 1, {})
					end))
				end
			elseif msg:sub(1, 8) == "unadmin " then
				local SelectedUsers = NameScan(msg:sub(9), game.Players:GetPlayers(), "Players", plr)[2]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						TakeAdmin(v, admins)
					end))
				end
			elseif msg:sub(1, 5) == "kick " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					if GetAdminLevel(v) == 0 then
						table.insert(KickedPlayers, v.Name)
						v:Kick()
						
						if PlayerLeaveNotify then
							for u, c in pairs(game.Players:GetPlayers()) do
								if c:IsFriendsWith(v.userId) then
									GenerateNotification(c, "Player Kicked", v.Name.." has been kicked from the game.", KickLineColor, KickNotColor, CharacterThumbnailPrefix..v.Name)
								else
									GenerateNotification(c, "Player Kicked", v.Name.." has been kicked from the game.", KickLineColor, RegNotColor, CharacterThumbnailPrefix..v.Name) 
								end
							end
						end
					end
				end
			elseif msg:sub(1, 4) == "ban " then
				local SelectedUsers = NameScan(msg:sub(5), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					if GetAdminLevel(v) == 0 then
						table.insert(KickedPlayers, v.Name)
						v:Kick()
						
						table.insert(banlist, v.Name)
						
						if PlayerLeaveNotify then
							for u, c in pairs(game.Players:GetPlayers()) do
								if c:IsFriendsWith(v.userId) then
									GenerateNotification(c, "Player Banned", v.Name.." has been banned from the game.", BanLineColor, BanNotColor, CharacterThumbnailPrefix..v.Name)
								else
									GenerateNotification(c, "Player Banned", v.Name.." has been banned from the game.", BanLineColor, RegNotColor, CharacterThumbnailPrefix..v.Name) 
								end
							end
						end
					end
				end
			elseif msg:sub(1, 6) == "unban " then
				local SelectedUsers = NameScan(msg:sub(7), game.Players:GetPlayers(), "Players", plr)[2]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						TakeAdmin(v, banlist)
					end))
				end
			elseif msg:sub(1, 9) == "loopkill " then
				local SelectedUsers = NameScan(msg:sub(10), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						local DoKill = true
						
						if (NegEffectsOff and GetAdminLevel(v) >= GetAdminLevel(plr)) and v ~= plr then
							DoKill = false
						end
						
						if DoKill then
							table.insert(LoopKills, v.Name)
							
							if v.Character then
								for u, c in pairs(v.Character:GetChildren()) do
									if c:IsA("Humanoid") then
										c.Health = 0
									end
								end
							end
						end
					end))
				end
			elseif msg:sub(1, 11) == "unloopkill " then
				local SelectedUsers = NameScan(msg:sub(12), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						for u, c in pairs(LoopKills) do
							if v.Name:lower() == c:lower() then
								table.remove(LoopKills, u)
							end
						end
					end))
				end
			elseif msg == "serverlock" or msg == "lockserver" or msg == "s lock" or msg == "slock" or msg == "server lock" then
				ServerLocked = true
				
				for i, v in pairs(game.Players:GetPlayers()) do
					coroutine.resume(coroutine.create(function()
						Hint("Server locked.", "System Message", v)
					end))
				end
			elseif msg == "serverunlock" or msg == "unlockserver" or msg == "s unlock" or msg == "sunlock" or msg == "unslock" or msg == "server unlock" then
				ServerLocked = false
				
				for i, v in pairs(game.Players:GetPlayers()) do
					coroutine.resume(coroutine.create(function()
						Hint("Server unlocked.", "System Message", v)
					end))
				end
			elseif msg == "grouplock" then
				GroupLocked = true
				
				for i, v in pairs(game.Players:GetPlayers()) do
					coroutine.resume(coroutine.create(function()
						Hint("Server group locked.", "System Message", v)
					end))
				end
			elseif msg == "groupunlock" or msg == "ungrouplock" then
				GroupLocked = false
				
				for i, v in pairs(game.Players:GetPlayers()) do
					coroutine.resume(coroutine.create(function()
						Hint("Server group unlocked.", "System Message", v)
					end))
				end
			elseif msg == "shutdown" then
				local PlrName = plr.Name
				
				for i, v in pairs(game.Players:GetPlayers()) do
					coroutine.resume(coroutine.create(function()
						if GetAdminLevel(v) <= GetAdminLevel(plr) then
							table.insert(KickedPlayers, v.Name)
							v:Kick()
						end
					end))
				end
				
				wait(0.1)
				
				for i, v in pairs(game.Players:GetPlayers()) do
					coroutine.resume(coroutine.create(function()
						GenerateNotification(v, "Server Shutdown", "The server has been shut down by "..PlrName..".", RegLineColor, RegNotColor, SystemThumbnail)
					end))
				end
			elseif msg:sub(1, 6) == "place " then
				local SaidNames = nil
				local Space = nil
				
				for i = 7, msg:len() do
					if msg:sub(i, i) == " " then
						Space = i
						SaidNames = NameScan(msg:sub(7, Space-1), game.Players:GetPlayers(), "Players", plr)[1]
						break
					end
				end
				
				if Space ~= nil then
					if tonumber(msg:sub(Space+1)) then
						local PlaceID = tonumber(msg:sub(Space+1))
						
						for i, v in pairs(SaidNames) do
							print("Reached")
							game:GetService("TeleportService"):Teleport(PlaceID, v)
						end
					end
				end
			end
		end
		
		if GetAdminLevel(plr) >= 3 and RunCommands then
			if msg:sub(1, 3) == "sa " then
				local SelectedUsers = NameScan(msg:sub(4), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						GiveAdmin(v, superadmins, 2, {admins})
					end))
				end
			elseif msg:sub(1, 5) == "unsa " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[2]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						TakeAdmin(v, superadmins)
					end))
				end
			elseif msg:sub(1, 8) == "chatoff " then
				local SelectedUsers = NameScan(msg:sub(9), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						if GetAdminLevel(v) == 0 then
							local PlrGui = v:WaitForChild("PlayerGui")
							local ChatDisable = script.Skel_ScriptStorage.Skel_ChatDisable:Clone()
							ChatDisable.Parent = PlrGui
							ChatDisable.Disabled = false
						end
					end))
				end
			elseif msg:sub(1, 7) == "chaton " then
				local SelectedUsers = NameScan(msg:sub(8), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						local PlrGui = v:WaitForChild("PlayerGui")
						local ChatEnable = script.Skel_ScriptStorage.Skel_ChatEnable:Clone()
						ChatEnable.Parent = PlrGui
						ChatEnable.Disabled = false
					end))
				end
			elseif msg == "hatcleanon" then
				AutoHatClean = true
			elseif msg == "hatcleanoff" then
				AutoHatClean = false
			elseif msg == "toolcleanon" then
				AutoToolClean = true
			elseif msg == "toolcleanoff" then
				AutoToolClean = false
			elseif msg:sub(1, 9) == "spawnpad " then
			local amounttospawn = tonumber(msg:sub(10))
			local padsspawned = 0
			while padsspawned < amounttospawn do
			local spawnpad = script.MovingBonusTemp:Clone()
			spawnpad.RandomValue.Value = 1 + padsspawned
			spawnpad.Parent = game.Workspace
			padsspawned = padsspawned + 1
			end
			elseif msg:sub(1, 13) == "spawngoldpad " then
			local amounttospawn = tonumber(msg:sub(14))
			local padsspawned = 0
			while padsspawned < amounttospawn do
			local spawnpad = script.MovingBonusGoldTemp:Clone()
			spawnpad.RandomValue.Value = 1 + padsspawned
			spawnpad.Parent = game.Workspace
			padsspawned = padsspawned + 1
			end
			elseif msg:sub(1, 16) == "spawndiamondpad " then
			local amounttospawn = tonumber(msg:sub(17))
			local padsspawned = 0
			while padsspawned < amounttospawn do
			local spawnpad = script.MovingBonusDiamondTemp:Clone()
			spawnpad.RandomValue.Value = 1 + padsspawned
			spawnpad.Parent = game.Workspace
			padsspawned = padsspawned + 1
			end
			elseif msg:sub(1, 14) == "spawntrollpad " then
			local amounttospawn = tonumber(msg:sub(15))
			local padsspawned = 0
			while padsspawned < amounttospawn do
			local spawnpad = script.MovingBonusFakeTemp:Clone()
			spawnpad.RandomValue.Value = 1 + padsspawned
			spawnpad.Parent = game.Workspace
			padsspawned = padsspawned + 1
			end
			elseif msg:sub(1, 14) == "spawntailspad " then
			local amounttospawn = tonumber(msg:sub(15))
			local padsspawned = 0
			while padsspawned < amounttospawn do
			local spawnpad = script.MovingBonusTailsTemp:Clone()
			spawnpad.RandomValue.Value = 1 + padsspawned
			spawnpad.Parent = game.Workspace
			padsspawned = padsspawned + 1
			end
			end
		end
		
		if GetAdminLevel(plr) >= 4 and RunCommands then
			if msg:sub(1, 3) == "ua " then
				local SelectedUsers = NameScan(msg:sub(4), game.Players:GetPlayers(), "Players", plr)[1]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						GiveAdmin(v, ultraadmins, 3, {admins, superadmins})
					end))
				end
			elseif msg:sub(1, 5) == "unua " then
				local SelectedUsers = NameScan(msg:sub(6), game.Players:GetPlayers(), "Players", plr)[2]
				
				for i, v in pairs(SelectedUsers) do
					coroutine.resume(coroutine.create(function()
						TakeAdmin(v, ultraadmins)
					end))
				end
			elseif msg == "funcmdson" or "funcommandson" then
				FunCommands = true
			elseif msg == "funcmdsoff" or "funcommandsoff" then
				FunCommands = false
			end
		end
		
		if AddToLogs then
			table.insert(CommandLogs, 1, {plr.Name, msg})
			
			if #CommandLogs > 100 then
				for i = 101, #CommandLogs do
					table.remove(CommandLogs, i)
				end
			end
		end
	end
end

function NewPlayer(plr)
	local function IsLoopKilled(plr)
		for i, v in pairs(LoopKills) do
			if plr.Name:lower() == v:lower() then
				return true
			end
		end
		return false
	end
	
	plr.CharacterAdded:connect(function(chr)
		if not plr:FindFirstChild("Skel_Prefix") and not plr.PlayerGui:FindFirstChild("Skel_PrefixStartup") then
			local prefixvalue = Instance.new("StringValue", plr)
			prefixvalue.Name = "Skel_Prefix"
			prefixvalue.Value = DefaultPrefix
		end
		
		if not plr:FindFirstChild("Skel_SystemColor") and not plr.PlayerGui:FindFirstChild("Skel_SCStartup") then
			local SSC = Instance.new("Color3Value", plr)
			SSC.Name = "Skel_SystemColor"
			SSC.Value = Color3.new(29/255,29/255,29/255)
		end
		
		if plr:FindFirstChild("Skel_CurrentSM") then
			local csm = plr:FindFirstChild("Skel_CurrentSM")
			local Header = csm:FindFirstChild("Header").Value
			local Body = csm:FindFirstChild("Body").Value
			
			ScreenMessage(plr, Header, Body)
		end
		
		if IsLoopKilled(plr) then
			repeat wait() until plr.Character
			local humanoid = plr.Character:WaitForChild("Humanoid")
			humanoid.Health = 0
		end
	end)
	
	if not plr:FindFirstChild("Skel_Prefix") and not plr.PlayerGui:FindFirstChild("Skel_PrefixStartup") then
		local prefixvalue = Instance.new("StringValue", plr)
		prefixvalue.Name = "Skel_Prefix"
		prefixvalue.Value = DefaultPrefix
	end
	
	if not plr:FindFirstChild("Skel_SystemColor") and not plr.PlayerGui:FindFirstChild("Skel_SCStartup") then
		local SSC = Instance.new("Color3Value", plr)
		SSC.Name = "Skel_SystemColor"
		SSC.Value = Color3.new(29/255,29/255,29/255)
	end
	
	CheckGroupAdmin(plr)
	CheckGamepassAdmin(plr)
	
	if not plr:FindFirstChild("Skel_CurrentSM") then
	end
	
	local w = Instance.new("IntValue", plr)
	w.Name = "Skel_Welcomed"
	game:GetService("Debris"):AddItem(w, 10)
	
	local PlrKicked = false
	
	local ScreenGui = Instance.new("ScreenGui", plr)
	local Frame = Instance.new("Frame", ScreenGui)
	
	Frame.Position = UDim2.new(0.5,0,0.5,0)
	
	if not plr:FindFirstChild("Skel_MinXLength") then
		local MinX = Instance.new("IntValue", plr)
		MinX.Name = "Skel_MinXLength"
		MinX.Value = Frame.AbsolutePosition.X
	end
	
	if not plr:FindFirstChild("Skel_MinYLength") then
		local MinY = Instance.new("IntValue", plr)
		MinY.Name = "Skel_MinYLength"
		MinY.Value = Frame.AbsolutePosition.Y
	end
	
	ScreenGui:Destroy()
	
	if CheckIfBanned(plr) then
		PlrKicked = true
	end
	
	if CheckIfMuted(plr) then
		local mutescript = script.Skel_ScriptStorage.Skel_ChatDisable:Clone()
		local PlrGui = plr:WaitForChild("PlayerGui")
		mutescript.Parent = PlrGui
		mutescript.Disabled = false
	end
	
	if ServerIsLocked(plr) then
		PlrKicked = true
	end
	
	if ServerIsGroupLocked(plr) then
		PlrKicked = true
	end
	
	if PlrKicked then
		wait(1)
		table.insert(KickedPlayers, plr.Name)
		plr:Kick()
		
		if PlayerLeaveNotify then
			for i, v in pairs(game.Players:GetPlayers()) do
				if v:IsFriendsWith(plr.userId) then
					GenerateNotification(v, "Player Join Attempt", plr.Name.." has attempted to join the game.", KickLineColor, KickNotColor, CharacterThumbnailPrefix..plr.Name)
				else
					GenerateNotification(v, "Player Join Attempt", plr.Name.." has attempted to join the game.", KickLineColor, RegNotColor, CharacterThumbnailPrefix..plr.Name) 
				end
			end
		end
	end
	
	if not PlrKicked and PlayerEnterNotify then
		for i, v in pairs(game.Players:GetPlayers()) do
			if v ~= plr then
				if v:IsFriendsWith(plr.userId) then
					GenerateNotification(v, "Player entered", plr.Name.." has joined the game.", EnterLineColor, EnterNotColor, CharacterThumbnailPrefix..plr.Name)
				else
					GenerateNotification(v, "Player entered", plr.Name.." has joined the game.", EnterLineColor, RegNotColor, CharacterThumbnailPrefix..plr.Name)
				end
			end
		end
	end
	
	plr.Chatted:connect(function(msg, rec) AdminCommands(msg, rec, plr) end)
end

game.Players.PlayerAdded:connect(NewPlayer)

for i, v in pairs(game.Players:GetPlayers()) do
	NewPlayer(v)
end

game.Players.PlayerRemoving:connect(function(plr)
	local NotifyLeave = true
	
	wait(0.5)
	
	for i, v in pairs(KickedPlayers) do
		if v == plr.Name then
			table.remove(KickedPlayers, i)
			NotifyLeave = false
		end
	end
	
	if NotifyLeave then
		for i, v in pairs(game.Players:GetPlayers()) do
			if v:IsFriendsWith(plr.userId) then
				GenerateNotification(v, "Player Left", plr.Name.." has left the game.", KickLineColor, KickNotColor, CharacterThumbnailPrefix..plr.Name)
			else
				GenerateNotification(v, "Player Left", plr.Name.." has left the game.", KickLineColor, RegNotColor, CharacterThumbnailPrefix..plr.Name) 
			end
		end
	end
end)
