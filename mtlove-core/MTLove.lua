--[[	MTLove 2 is a 'small' World Of Warcraft Addon which adds
		a "target of mouseover" function to the client.
		Copyright (C) 2006-2013 Herrmann, Tom
		from Randoom.org edit by malfdawg

		This file is part of MTLove 2.

		MTLove 2 is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		version 2 as published by the Free Software Foundation.

		MTLove 2 is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program; if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.]]

local UpdateInterval				= 0.1;
local do_stats_at_count				= 25;
local Frames_On;
local TargetCounter_On;
local FocusCounter_On;
local DefaultTT						= "GameTooltip";
local AddToWidth					= 20 / UIParent:GetScale();
local MinWidth						= 80 / UIParent:GetScale();

-- default class order, +Tank in front and +Pet at the end
local class_sort_order				= {"TANK"};
local lastIndex;
for i in ipairs(CLASS_SORT_ORDER) do
	class_sort_order[i + 1]			= CLASS_SORT_ORDER[i];
	lastIndex						= i + 1;
end
class_sort_order[lastIndex+1]		= "PET";

-- tanking buffs names
local bearformBuff					= GetSpellInfo(5487);
local catformBuff					= GetSpellInfo(768);
local moonkinformBuff				= GetSpellInfo(24858);
local dktankBuff					= GetSpellInfo(48263);
local palatankBuff					= GetSpellInfo(25780);

-- MTLove's armor type order
local armorType_sort_order			= {
										"TANK",
										"PLATE",
										"MAIL",
										"LEATHER",
										"CLOTH",
										"PET"
									};

-- default class colors, +Tank in front and +Pet at the end
local class_colors					= { ["TANK"] = {r = 0.75, g = 0.75, b = 0.75} } -- light gray;
for class in pairs(RAID_CLASS_COLORS) do
		class_colors[class]			= RAID_CLASS_COLORS[class];
end
class_colors["PET"]					= {r = 0.60, g = 0.00, b = 1.00}; -- purple

-- MTLove's armor class colors
local armorType_colors				= {
										["TANK"]	= class_colors["TANK"],
										["PLATE"]	= {r = 0.00, g = 1.00, b = 0.00}, -- green
										["MAIL"]	= {r = 1.00, g = 1.00, b = 0.00}, -- yellow
										["LEATHER"]	= {r = 1.00, g = 0.40, b = 0.00}, -- orange
										["CLOTH"]	= {r = 1.00, g = 0.00, b = 0.00}, -- red
										["PET"]		= class_colors["PET"]
									};

-- MTLove's generic color classes
local color_unseparated				= {r = 0.40, g = 0.40, b = 0.40}; -- dark gray
local color_npc						= class_colors["PET"];
local color_stun					= color_unseparated;
local color_mo_self					= color_stun;
local color_nothing					= color_stun;

local end_color						= "|r";
local stats_data					= {};

-- local alias' for MTLove's global functions
local get_SavedVariables			= MTLove_get_SavedVariables;
local get_Stats						= MTLove_get_Stats;

-- local alias' for MTLove's global 'variables'
local EventHandler;
local TargetCounter_Counter;
local TargetCounter_Counter_Line0;
local FocusCounter_Counter;
local FocusCounter_Counter_Line0;
local Frame;
local Frame_Line0;
local Frame_Counter;
local Frame_Counter_Line0;
local Frame_StatusBar0;
local Frame_StatusBar1;
local TT_Frame;
local TT_Frame_Line0;
local TT_Frame_Line1;
local TT_Frame_Counter;
local TT_Frame_Counter_Line0;
local TT_Frame_StatusBar;

-- local alias' for global functions
local alias_UnitExists				= UnitExists;
local alias_UnitIsDeadOrGhost		= UnitIsDeadOrGhost;
local alias_UnitIsUnit				= UnitIsUnit;
local alias_UnitClass				= UnitClass;
local alias_UnitLevel				= UnitLevel;
local alias_UnitHealth				= UnitHealth;
local alias_UnitHealthMax			= UnitHealthMax;
local alias_UnitCreatureType		= UnitCreatureType;
local alias_UnitClassification		= UnitClassification;
local alias_UnitName				= UnitName;
local alias_UnitBuff				= UnitBuff;
local alias_UnitIsFriend			= UnitIsFriend;
local alias_UnitIsEnemy				= UnitIsEnemy;
local alias_UnitIsPlayer			= UnitIsPlayer;
local alias_UnitPlayerOrPetInParty	= UnitPlayerOrPetInParty;
local alias_UnitPlayerOrPetInRaid	= UnitPlayerOrPetInRaid;
local alias_UnitPlayerControlled	= UnitPlayerControlled;
local alias_UnitAffectingCombat		= UnitAffectingCombat;
local alias_UnitIsTapped			= UnitIsTapped;
local alias_GetNumPartyMembers      = GetNumSubgroupMembers;
local alias_GetNumRaidMembers       = GetNumGroupMembers;
local alias_GetPartyAssignment		= GetPartyAssignment;
local alias_UnitGroupRolesAssigned	= UnitGroupRolesAssigned;

-- local functions to acquire other addons MainTank-Lists
local getORA3Tanks					= function() return false end;
local getCTRATanks					= function() return false end;

-- local alias' for global 'variables'
local mo							= "mouseover";
local mot							= "mouseovertarget";

function MTLove_OnLoad()
	MTLove_EventHandler:RegisterEvent("ADDON_LOADED");
	MTLove_EventHandler:RegisterEvent("PLAYER_TARGET_CHANGED");
	MTLove_EventHandler:RegisterEvent("PLAYER_FOCUS_CHANGED");
	MTLove_EventHandler:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	SLASH_MTLove1 = "/mtlove";
	SlashCmdList["MTLove"] = MTLove_GUI_show;
	MTLove_UI_PostStatus("onload");
end

function MTLove_OnEvent(self, event, ...)
	local arg1 = ...
	if ((event == "UPDATE_MOUSEOVER_UNIT") or (event == "PLAYER_TARGET_CHANGED") or (event == "PLAYER_FOCUS_CHANGED")) then
		MTLove_activate();
		self.TimeSinceLastUpdate	= UpdateInterval;
	elseif (event == "ADDON_LOADED") and arg1 == "MTLove" then
		EventHandler				= MTLove_EventHandler;
		TargetCounter_Counter		= MTLove_TargetCounter_Counter;
		TargetCounter_Counter_Line0	= MTLove_TargetCounter_Counter_Line0;
		FocusCounter_Counter		= MTLove_FocusCounter_Counter;
		FocusCounter_Counter_Line0	= MTLove_FocusCounter_Counter_Line0;
		Frame						= MTLove_Frame;
		Frame_Line0					= MTLove_Frame_Line0;
		Frame_Counter				= MTLove_Frame_Counter;
		Frame_Counter_Line0			= MTLove_Frame_Counter_Line0;
		Frame_StatusBar0			= MTLove_Frame_StatusBar0;
		Frame_StatusBar1			= MTLove_Frame_StatusBar1;
		TT_Frame					= MTLove_TT_Frame;
		TT_Frame_Line0				= MTLove_TT_Frame_Line0;
		TT_Frame_Line1				= MTLove_TT_Frame_Line1;
		TT_Frame_Counter			= MTLove_TT_Frame_Counter;
		TT_Frame_Counter_Line0		= MTLove_TT_Frame_Counter_Line0;
		TT_Frame_StatusBar			= MTLove_TT_Frame_StatusBar;
		-- check for optional addon
		if (IsAddOnLoaded("TipBuddy")) then
			DefaultTT				= "TipBuddyTooltip";
		end
		if (IsAddOnLoaded("oRA3")) then
			getORA3Tanks			= function() return oRA3:GetSortedTanks() end;
		end
		if (IsAddOnLoaded("CT_RaidAssist")) then
			getCTRATanks			= function() return CT_RATarget.MainTanks end;
		end
		MTLove_Stats_Reset();
		MTLove_loadVariables();
		MTLove_activate();
		EventHandler:UnregisterEvent("ADDON_LOADED");
		MTLove_UI_PostStatus("variables_loaded");
	end
end

function MTLove_activate()
	TargetCounter_On	= nil;
	FocusCounter_On		= nil;
	Frames_On			= nil;
	if (alias_UnitExists(mo) and (not alias_UnitIsDeadOrGhost(mo)) and get_SavedVariables("Frame")) then
		Frame:Show();
		Frame:SetBackdropBorderColor(1, 1, 1);
		Frame:SetBackdropColor(0.09, 0.09, 0.19);
		Frame_Counter:SetBackdropBorderColor(1, 1, 1);
		Frame_Counter:SetBackdropColor(0.09, 0.09, 0.19);
		if (get_SavedVariables("Frame_Counter")) then
			Frame_Counter:Show();
		else
			Frame_Counter:Hide();
		end
		if (get_SavedVariables("Frame_Mo_Bar")) then
			Frame_StatusBar0:Show();
		else
			Frame_StatusBar0:Hide();
		end
		if (get_SavedVariables("Frame_Mot_Bar")) then
			Frame_StatusBar1:Show();
		else
			Frame_StatusBar1:Hide();
		end
		Frame:SetAlpha(0);
		Frame_Counter:SetAlpha(0);
		Frames_On	= true;
	else
		Frame:Hide();
	end
	if (alias_UnitExists(mo) and (not alias_UnitIsDeadOrGhost(mo)) and get_SavedVariables("TT")) then
		TT_Frame:Show();
		TT_Frame:SetBackdropBorderColor(1, 1, 1);
		TT_Frame:SetBackdropColor(0.09, 0.09, 0.19);
		TT_Frame:ClearAllPoints();
		TT_Frame:SetPoint("BOTTOMRIGHT", DefaultTT, "BOTTOMLEFT");
		TT_Frame:SetAlpha(0);
		TT_Frame_Counter:SetBackdropBorderColor(1, 1, 1);
		TT_Frame_Counter:SetBackdropColor(0.09, 0.09, 0.19);
		TT_Frame_Counter:ClearAllPoints();
		TT_Frame_Counter:SetPoint("BOTTOMLEFT", DefaultTT, "TOPLEFT");
		TT_Frame_Counter:SetAlpha(0);
		if (get_SavedVariables("TT_Counter")) then
			TT_Frame_Counter:Show();
		else
			TT_Frame_Counter:Hide();
		end
		Frames_On	= true;
	else
		TT_Frame:Hide();
		TT_Frame_Counter:Hide();
	end
	if (TargetFrame:IsShown() and alias_UnitExists("target") and (not alias_UnitIsDeadOrGhost("target")) and get_SavedVariables("TargetCounter")) then
		TargetCounter_Counter:Show();
		TargetCounter_Counter:SetBackdropBorderColor(1, 1, 1);
		TargetCounter_Counter:SetBackdropColor(0.09, 0.09, 0.19);
		
		TargetCounter_On	= true;
	else
		TargetCounter_Counter:Hide();
	end
	if (FocusFrame:IsShown() and alias_UnitExists("focus") and (not alias_UnitIsDeadOrGhost("focus")) and get_SavedVariables("FocusCounter")) then		
		FocusCounter_Counter:Show();
		FocusCounter_Counter:SetBackdropBorderColor(1, 1, 1);
		FocusCounter_Counter:SetBackdropColor(0.09, 0.09, 0.19);
		
		FocusCounter_On		= true;
	else
		FocusCounter_Counter:Hide();
	end
	if (Frames_On or TargetCounter_On or FocusCounter_On) then
		EventHandler:Show();
		--MTLove_UI_Debug("EvHandler", "show");
	else
		EventHandler:Hide();
		--MTLove_UI_Debug("EvHandler", "hide");
	end
	MTLove_Update_Memory_Usage();
end

function MTLove_OnUpdate(self, elapsed)
	self.TimeSinceLastUpdate	= self.TimeSinceLastUpdate + elapsed;
	if (self.TimeSinceLastUpdate > UpdateInterval) then
		MTLove_Reset_CPU_Usage();
		
		--MTLove_UI_Debug("TargetCounter_On", TargetCounter_On);
		--MTLove_UI_Debug("Frames_On", Frames_On);

		local Self_GroupMode		= nil;
		local Self_GroupMembers		= 0;
		if (alias_GetNumPartyMembers() > 0) then
			if (alias_GetNumRaidMembers() > 0) then
				Self_GroupMode		= "raid";
				Self_GroupMembers	= alias_GetNumRaidMembers();
			else
				Self_GroupMode		= "party";
				Self_GroupMembers	= alias_GetNumPartyMembers();
			end
		end

		--MTLove_UI_Debug("Self_GroupMode", Self_GroupMode);
		--MTLove_UI_Debug("Self_GroupMembers", Self_GroupMembers);
		
		MTLove_OnUpdate_Frames(Self_GroupMode, Self_GroupMembers);
		
		if (TargetCounter_On) then
			MTLove_OnUpdate_TargetCounter(Self_GroupMode, Self_GroupMembers);
		end
		if (FocusCounter_On) then
			MTLove_OnUpdate_FocusCounter(Self_GroupMode, Self_GroupMembers);
		end
		
		MTLove_Update_Memory_Usage();
		MTLove_Update_CPU_Usage();
		self.TimeSinceLastUpdate	= 0;
	else
		MTLove_arrangeFrame();
	end
	-- no event is fired when the mouseover is dead or does not exsist... fix for that
	if ((not alias_UnitExists(mo) or alias_UnitIsDeadOrGhost(mo)) and (not alias_UnitExists("target") or alias_UnitIsDeadOrGhost("target")) and (not alias_UnitExists("focus") or alias_UnitIsDeadOrGhost("focus"))) then
		MTLove_activate();
	end
end

function MTLove_OnUpdate_Frames(Self_GroupMode, Self_GroupMembers)
	if (Frames_On) then
		local mo_Unit_NotDead			= (not alias_UnitIsDeadOrGhost(mo)) and alias_UnitExists(mo);
		local Self_PartyOk				= Self_GroupMode or get_SavedVariables("Self_NotInParty");
		local mo_Unit_AffectedOk		= alias_UnitAffectingCombat(mo) or get_SavedVariables("Mo_OutOfCombat");

		--MTLove_UI_Debug("mo_Unit_NotDead", mo_Unit_NotDead);
		--MTLove_UI_Debug("Self_PartyOk", Self_PartyOk);
		--MTLove_UI_Debug("mo_Unit_AffectedOk", mo_Unit_AffectedOk);

		if (mo_Unit_NotDead and Self_PartyOk and mo_Unit_AffectedOk) then
			local mot_Unit_NotDead		= (not alias_UnitIsDeadOrGhost(mot)) and alias_UnitExists(mot);
			local mot_Unit_Stun			= (not alias_UnitExists(mot)) and alias_UnitAffectingCombat(mo) and alias_UnitIsTapped(mo);
			local mot_Unit_Mo_Self		= alias_UnitIsUnit(mo, mot);
			local mot_Unit_Nothing		= (not mot_Unit_Stun) and (not alias_UnitExists(mot));

			local mo_Unit_Self			= alias_UnitIsUnit(mo, "player");
			local mo_Unit_OwnPet		= alias_UnitIsUnit(mo, "pet");
			local mo_Unit_Friend		= alias_UnitIsFriend(mo, "player");
			local mo_Unit_Enemy			= alias_UnitIsEnemy(mo, "player");
			local mo_Unit_PartyMember	= alias_UnitPlayerOrPetInParty(mo) or alias_UnitPlayerOrPetInRaid(mo);
			local mo_Unit_Player		= alias_UnitIsPlayer(mo);
			local mo_Unit_Pet			= alias_UnitPlayerControlled(mo);

			local mo_Type				= nil;
			local mo_Type_cleaned		= nil;

			if (mo_Unit_Self) then
				mo_Type = "self";
			elseif (mo_Unit_OwnPet) then
				mo_Type = "ownpet";
			else
				if (mo_Unit_Friend) then
					mo_Type = "friendly_";
					if (mo_Unit_PartyMember) then
						mo_Type = mo_Type .. "partymember_";
					end
				elseif (mo_Unit_Enemy) then
					mo_Type = "enemy_";
				else
					mo_Type = "neutral_";
				end
				if (mo_Unit_Player) then
					mo_Type = mo_Type .. "player";
				elseif (mo_Unit_Pet) then
					mo_Type = mo_Type .. "pet";
				else
					mo_Type = mo_Type .. "npc";
				end
			end

			if ((mo_Type == "self")								and false) then
				-- you never really want that, therefore no setting -> false
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "ownpet")						and false) then
				-- you never really want that, therefore no setting -> false
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "friendly_partymember_player")	and get_SavedVariables("Mo_Friendly_PartyMember_Player")) then
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "friendly_partymember_pet")		and get_SavedVariables("Mo_Friendly_PartyMember_Pet")) then
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "friendly_player")				and get_SavedVariables("Mo_Friendly_Player")) then
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "friendly_pet")					and get_SavedVariables("Mo_Friendly_Pet")) then
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "friendly_npc")					and get_SavedVariables("Mo_Friendly_Npc")) then
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "enemy_player")					and get_SavedVariables("Mo_Enemy_Player")) then
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "enemy_pet")					and get_SavedVariables("Mo_Enemy_Pet")) then
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "enemy_npc")					and get_SavedVariables("Mo_Enemy_Npc")) then
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "neutral_player")				and false) then
				-- impossible, therefore no setting -> false
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "neutral_pet")					and false) then
				-- impossible, therefore no setting -> false
				mo_Type_cleaned = mo_Type;
			elseif ((mo_Type == "neutral_npc")					and get_SavedVariables("Mo_Neutral_Npc")) then
				mo_Type_cleaned = mo_Type;
			end

			--MTLove_UI_Debug("mot_Unit_NotDead", mot_Unit_NotDead);
			--MTLove_UI_Debug("mot_Unit_Stun", mot_Unit_Stun);
			--MTLove_UI_Debug("mo_Type", mo_Type);
			--MTLove_UI_Debug("mo_Type_cleaned", mo_Type_cleaned);

			if ((mot_Unit_NotDead or mot_Unit_Stun or mot_Unit_Mo_Self or mot_Unit_Nothing) and mo_Type_cleaned) then
				local mot_Unit_Self			= alias_UnitIsUnit(mot, "player");
				local mot_Unit_OwnPet		= alias_UnitIsUnit(mot, "pet");
				local mot_Unit_Friend		= alias_UnitIsFriend(mot, "player");
				local mot_Unit_Enemy		= alias_UnitIsEnemy(mot, "player");
				local mot_Unit_PartyMember	= alias_UnitPlayerOrPetInParty(mot) or alias_UnitPlayerOrPetInRaid(mot);
				local mot_Unit_Player		= alias_UnitIsPlayer(mot);
				local mot_Unit_Pet			= alias_UnitPlayerControlled(mot);

				local mot_Type				= nil;
				local mot_Type_cleaned		= nil;

				if (mot_Unit_Stun) then
					mot_Type = "stun";
				elseif (mot_Unit_Mo_Self) then
					mot_Type = "mo";
				elseif (mot_Unit_Nothing) then
					mot_Type = "nothing";
				else
					if (mot_Unit_Self) then
						mot_Type = "self";
					elseif (mot_Unit_OwnPet) then
						mot_Type = "ownpet";
					else
						if (mot_Unit_Friend) then
							mot_Type = "friendly_";
							if (mot_Unit_PartyMember) then
								mot_Type = mot_Type .. "partymember_";
							end
						elseif (mot_Unit_Enemy) then
							mot_Type = "enemy_";
						else
							mot_Type = "neutral_";
						end
						if (mot_Unit_Player) then
							mot_Type = mot_Type .. "player";
						elseif (mot_Unit_Pet) then
							mot_Type = mot_Type .. "pet";
						else
							mot_Type = mot_Type .. "npc";
						end
					end
				end

				if ((mot_Type == "stun")							and get_SavedVariables("Mot_Stun")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "mo")							and get_SavedVariables("Mot_Mo_Self")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "nothing")						and get_SavedVariables("Mot_Nothing")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "self")						and get_SavedVariables("Mot_Self")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "ownpet")						and get_SavedVariables("Mot_OwnPet")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "friendly_partymember_player")	and get_SavedVariables("Mot_Friendly_PartyMember_Player")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "friendly_partymember_pet")	and get_SavedVariables("Mot_Friendly_PartyMember_Pet")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "friendly_player")				and get_SavedVariables("Mot_Friendly_Player")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "friendly_pet")				and get_SavedVariables("Mot_Friendly_Pet")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "friendly_npc")				and get_SavedVariables("Mot_Friendly_Npc")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "enemy_player")				and get_SavedVariables("Mot_Enemy_Player")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "enemy_pet")					and get_SavedVariables("Mot_Enemy_Pet")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "enemy_npc")					and get_SavedVariables("Mot_Enemy_Npc")) then
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "neutral_player")				and false) then
					-- impossible, therefore no setting -> false
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "neutral_pet")					and false) then
					-- impossible, therefore no setting -> false
					mot_Type_cleaned = mot_Type;
				elseif ((mot_Type == "neutral_npc")					and get_SavedVariables("Mot_Neutral_Npc")) then
					mot_Type_cleaned = mot_Type;
				end

				--MTLove_UI_Debug("mot_Type", mot_Type);
				--MTLove_UI_Debug("mot_Type_cleaned", mot_Type_cleaned);

				if (mot_Type_cleaned) then
					local use_count									= get_SavedVariables("Frame_Counter") or get_SavedVariables("TT_Counter");
					
					local mot_Name									= alias_UnitName(mot);
					
					local mot_Merge_Player							= (mot_Type == "self") or (mot_Type == "friendly_partymember_player") or (mot_Type == "friendly_player") or (mot_Type == "enemy_player") or (mot_Type == "neutral_player");
					local mot_Merge_Pet								= (mot_Type == "ownpet") or (mot_Type == "friendly_partymember_pet") or (mot_Type == "friendly_pet") or (mot_Type == "enemy_pet") or (mot_Type == "neutral_pet");
					local mot_Merge_Npc								= (mot_Type == "friendly_npc") or (mot_Type == "enemy_npc") or (mot_Type == "neutral_npc");
					local mot_IsTank								= (mot_Merge_Player and MTLove_UnitIsTank(mot, mot_Unit_PartyMember));
					local mot_IsHealer								= (mot_Merge_Player and MTLove_UnitIsHealer(mot, mot_Unit_PartyMember));
					local mot_class, mot_armorType, mot_classLoc	= MTLove_UnitToClassAndArmorType(mot);
					local mot_Classification						= nil;
					local count_result								= "";
					local width										= 0;
					local msg										= nil;
					local colors;

					if (get_SavedVariables("Classify_by_ArmorType")) then
						colors				= armorType_colors;
						mot_Classification	= mot_armorType;
					else
						colors				= class_colors;
						mot_Classification	= mot_class;
					end

					-- decide on color to use
					if (mot_Type == "stun") then
						color = color_stun;
					elseif (mot_Type == "mo") then
						color = color_mo_self;
					elseif (mot_Type == "nothing") then
						color = color_nothing;
					elseif (mot_Merge_Player or mot_Merge_Pet) then
						if (mot_IsTank) then
							color	= colors["TANK"];
						elseif (mot_Merge_Pet) then
							color	= colors["PET"];
						else
							color	= colors[mot_Classification];
						end
					elseif (mot_Merge_Npc) then
						color	= color_npc;
					end
					
					-- apply color
					msg = string.format("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255);
					
					if ((mot_IsTank or mot_IsHealer) and get_SavedVariables("Mot_Highlight")) then
						if (mot_IsTank) then
							msg = msg .. "[ " .. mot_Name .. " ]" ..end_color;
						else
							msg = msg .. "> " .. mot_Name .. " <" ..end_color;
						end
					elseif (mot_Type == "stun") then
						msg = msg .. MTLove_UI_FearStun .. end_color;
					elseif (mot_Type == "mo") then
						msg = msg .. MTLove_UI_Mot_Mo_Self .. end_color;
					elseif (mot_Type == "nothing") then
						msg = msg .. MTLove_UI_Mot_Nothing .. end_color;
					else
						msg = msg .. mot_Name .. end_color;
					end

					--MTLove_UI_Debug("msg_L0", msg);

					if (use_count and Self_GroupMode) then
						count_result	= MTLove_Count_PartyMembers_Targeting_Unit(Self_GroupMode, Self_GroupMembers, mo);
					end

					--MTLove_UI_Debug("count_result", count_result);

					if (get_SavedVariables("Frame")) then
						Frame_Line0:SetText(msg);
						width = Frame_Line0:GetStringWidth();
						if (width < MinWidth) then
							width = MinWidth;
						end
						Frame:SetWidth(width + AddToWidth);
						if (get_SavedVariables("Frame_Mo_Bar")) then
							Frame_StatusBar0:SetMinMaxValues(0, alias_UnitHealthMax(mo));
							Frame_StatusBar0:SetValue(alias_UnitHealth(mo));
						end
						if (get_SavedVariables("Frame_Mot_Bar")) then
							Frame_StatusBar1:SetMinMaxValues(0, alias_UnitHealthMax(mot));
							Frame_StatusBar1:SetValue(alias_UnitHealth(mot));
						end
						Frame:SetAlpha(1);
						MTLove_arrangeFrame();
						if (use_count and Self_GroupMode) then
							Frame_Counter_Line0:SetText(count_result);
							width = Frame_Counter_Line0:GetStringWidth();
							Frame_Counter:SetWidth(width + AddToWidth);
							Frame_Counter:SetAlpha(1);
						else
							Frame_Counter:SetAlpha(0);
						end
					end
					if (get_SavedVariables("TT")) then
						local mot_Level			= alias_UnitLevel(mot);
						local mot_CreatureType	= alias_UnitCreatureType(mot);
						local mot_Plus			= alias_UnitClassification(mot);
						local width2			= 0;

						TT_Frame_Line0:SetText(msg);
						if ((mot_Type == "stun") or (mot_Type == "mo") or (mot_Type == "nothing")) then
							msg = "";
						elseif (mot_Level > 0) then
							msg = MTLove_UI_Level .. " " .. mot_Level;
							if (mot_Plus and (mot_Plus ~= "normal")) then
								msg = msg .. "+ ";
							else
								msg = msg .. " ";
							end
							if (mot_Merge_Player) then
								if (mot_Type == "self") then
									msg = msg .. mot_classLoc .. " (" .. MTLove_UI_Self .. ")";
								else
									msg = msg .. mot_classLoc .. " (" .. MTLove_UI_Player .. ")";
								end
							else
								if (mot_Merge_Pet) then
									if (mot_Type == "ownpet") then
										mot_CreatureType = MTLove_UI_OwnPet;
									else
										mot_CreatureType = MTLove_UI_Pet;
									end
								elseif (mot_Merge_Npc) then
									mot_CreatureType = MTLove_UI_NPC;
								end
								msg = msg .. mot_CreatureType;
							end
						else
							if (not mot_CreatureType) then
								mot_CreatureType = "?!?";
							end
							if (mot_Plus == "worldboss") then
								msg = MTLove_UI_Boss .. mot_CreatureType;
							else
								msg = "?!? " .. mot_CreatureType;
							end
						end

						--MTLove_UI_Debug("msg_TT_L1", msg);

						TT_Frame_Line1:SetText(msg);
						width = TT_Frame_Line0:GetWidth();
						width2 = TT_Frame_Line1:GetWidth();
						if (width2 > width) then
							width = width2;
						end
						if (width < MinWidth) then
							width = MinWidth;
						end
						TT_Frame:SetWidth(width + AddToWidth);
						TT_Frame_StatusBar:SetMinMaxValues(0, alias_UnitHealthMax(mot));
						TT_Frame_StatusBar:SetValue(alias_UnitHealth(mot));
						if (msg == "") then
							TT_Frame:SetHeight(35);
						else
							TT_Frame:SetHeight(48);
						end
						TT_Frame:SetAlpha(1);
						if (use_count and Self_GroupMode) then
							TT_Frame_Counter_Line0:SetText(count_result);
							width = TT_Frame_Counter_Line0:GetStringWidth();
							TT_Frame_Counter:SetWidth(width + AddToWidth);
							TT_Frame_Counter:SetAlpha(1);
						else
							TT_Frame_Counter:SetAlpha(0);
						end
					end
					return;
				end
			end
		end
	end
	Frame:SetAlpha(0);
	TT_Frame:SetAlpha(0);
	TT_Frame_Counter:SetAlpha(0);
end

function MTLove_OnUpdate_TargetCounter(Self_GroupMode, Self_GroupMembers)
	local width					= nil;
	if (Self_GroupMode) then
		local count_tot_result	= MTLove_Count_PartyMembers_Targeting_Unit(Self_GroupMode, Self_GroupMembers, "target");

		--MTLove_UI_Debug("count_tot_result", count_tot_result);

		TargetCounter_Counter_Line0:SetText(count_tot_result);
		width = TargetCounter_Counter_Line0:GetStringWidth();
		TargetCounter_Counter:SetWidth(width + AddToWidth);
		TargetCounter_Counter:SetAlpha(1);
		if (TargetFrameNumericalThreat:IsShown()) then
			TargetCounter_Counter:ClearAllPoints();
			TargetCounter_Counter:SetPoint("RIGHT", "TargetFrameNumericalThreat", "LEFT", 5, 2);
		else
			TargetCounter_Counter:ClearAllPoints();
			TargetCounter_Counter:SetPoint("BOTTOM", "TargetFrame", "TOP", -50, -22);
		end
	else
		TargetCounter_Counter:SetAlpha(0);
	end
end

function MTLove_OnUpdate_FocusCounter(Self_GroupMode, Self_GroupMembers)
	if (FocusCounter_On) then
		local width					= nil;
		if (Self_GroupMode) then
			local count_tof_result	= MTLove_Count_PartyMembers_Targeting_Unit(Self_GroupMode, Self_GroupMembers, "focus");

			--MTLove_UI_Debug("count_tof_result", count_tof_result);
			
			FocusCounter_Counter_Line0:SetText(count_tof_result);
			width = FocusCounter_Counter_Line0:GetStringWidth();
			FocusCounter_Counter:SetWidth(width + AddToWidth);
			FocusCounter_Counter:SetAlpha(1);
			if (FocusFrameNumericalThreat:IsShown()) then
				FocusCounter_Counter:ClearAllPoints();
				FocusCounter_Counter:SetPoint("RIGHT", "FocusFrameNumericalThreat", "LEFT", 5, 2);
			else
				FocusCounter_Counter:ClearAllPoints();
				FocusCounter_Counter:SetPoint("BOTTOM", "FocusFrame", "TOP", -50, -22);
			end
		else
			FocusCounter_Counter:SetAlpha(0);
		end

	end
end

function MTLove_arrangeFrame()
	local x, y = GetCursorPosition();
	x = (x + 3) / UIParent:GetScale() + get_SavedVariables("Frame_Offset_X");
	y = y / UIParent:GetScale() + get_SavedVariables("Frame_Offset_Y");
	Frame:ClearAllPoints();
	Frame:SetPoint("BOTTOMLEFT", x, y);
end

function MTLove_UnitIsTank(unit, unit_partyMember)
	if (getORA3Tanks()) then
		local list	= getORA3Tanks();
		for i = 1, 10, 1 do
			if (list[i] == alias_UnitName(unit)) then
				return true;
			end
		end
		return false;
	end
	
	if (get_SavedVariables("Experimental_Features") and getCTRATanks()) then
		for k, v in pairs(getCTRATanks()) do
			if (v[2] == UnitName(unit)) then
				return true;
			end
		end
		return false;
	end
	
	local classLoc, class		= alias_UnitClass(unit);
	local raidMainTankUnit		= nil;
	local groupRoleAssignment	= "NONE";
	
	if (unit_partyMember) then
		raidMainTankUnit		= alias_GetPartyAssignment("MAINTANK");
		groupRoleAssignment		= alias_UnitGroupRolesAssigned(unit); -- assignment set by dungeonfinder
	end
	
	--MTLove_UI_Debug("raidMainTankUnit", raidMainTankUnit);
	--MTLove_UI_Debug("groupRoleAssignment", groupRoleAssignment);
	
	if (raidMainTankUnit) then -- some unit is set as MainTank in raid
		if (alias_GetPartyAssignment("MAINTANK", unit)) then
			return true;
		else
			return false;
		end
	end
	
	if(not (groupRoleAssignment == "NONE")) then -- unit has some role
		if (groupRoleAssignment == "TANK") then
			return true;
		else
			return false;
		end
	end
	
	if (class == "WARRIOR") then
		return true;
	elseif ((class == "DEATHKNIGHT") or (class == "DRUID") or (class == "PALADIN")) then
		local i = 1;
		while (alias_UnitBuff(unit, i) ~= nil) do
			local buffName = alias_UnitBuff(unit, i);
			
			--MTLove_UI_Debug("buffName", buffName);
			
			if ((buffName == bearformBuff) or (buffName == dktankBuff) or (buffName == palatankBuff)) then
				return true;
			end
			
			i = i + 1;
		end
	end

	return false;
end

function MTLove_UnitIsHealer(unit, unit_partyMember)
	local classLoc, class		= alias_UnitClass(unit);
	local groupRoleAssignment	= "NONE";
	
	if (unit_partyMember) then
		groupRoleAssignment		= alias_UnitGroupRolesAssigned(unit); -- assignment set by dungeonfinder
	end
	
	if(not (groupRoleAssignment == "NONE")) then -- unit has some role
		if (groupRoleAssignment == "HEALER") then
			return true;
		else
			return false;
		end
	end
	
	if ((class == "SHAMAN") or (class == "PRIEST")) then
		return true;
	elseif (class == "PALADIN") then
		return (not MTLove_UnitIsTank(unit, unit_partyMember));
	elseif (class == "DRUID") then
		local i = 1;
		while (alias_UnitBuff(unit, i) ~= nil) do
			local buffName = alias_UnitBuff(unit, i);
			
			--MTLove_UI_Debug("buffName", buffName);
			
			if ((buffName == bearformBuff) or (buffName == catformBuff) or (buffName == moonkinformBuff)) then
				return false;
			end
			
			i = i + 1;
		end
		return true;
	end
	return false;
end

function MTLove_UnitCanControlPet(unit)
	local classLoc, class	= alias_UnitClass(unit);
	return MTLove_ClassCanControlPet(class);
end
function MTLove_ClassCanControlPet(class)
	return ((class == "HUNTER") or (class == "WARLOCK") or (class == "DEATHKNIGHT"));
end

function MTLove_UnitToClassAndArmorType(unit)
	local level				= alias_UnitLevel(unit);
	local classLoc, class	= alias_UnitClass(unit);
	
	return class, MTLove_ClassToArmorType(class, level), classLoc;
end
function MTLove_UnitToArmorType(unit)
	local level				= alias_UnitLevel(unit);
	local classLoc, class	= alias_UnitClass(unit);
	
	return MTLove_ClassToArmorType(class, level);
end
function MTLove_ClassToArmorType(class, level)
	if ((level == nil) or (level >= 40)) then
		if ((class == "WARRIOR") or (class == "DEATHKNIGHT") or (class == "PALADIN")) then
			return "PLATE";
		elseif ((class == "SHAMAN") or (class == "HUNTER")) then
			return "MAIL";
		elseif ((class == "DRUID") or (class == "ROGUE")) then
			return "LEATHER";
		else
			return "CLOTH";
		end
	else
		if ((class == "WARRIOR") or (class == "PALADIN")) then
			return "MAIL";
		elseif ((class == "SHAMAN") or (class == "HUNTER") or (class == "DRUID") or (class == "ROGUE")) then
			return "LEATHER";
		else
			return "CLOTH";
		end
	end
end

function MTLove_Count_PartyMembers_Targeting_Unit(Self_GroupMode, Self_GroupMembers, unit)	
	local typesInGroup				= {};
	local typesTargetingUnit		= {};
	
	local memberToTest;
	local membersTarget;
	local membersPetToTest;
	local membersPetTarget;
	local class, armorType;
	local unitClassification;
	local memberIsTank;
	
	-- count members of your raid/party (who target the unit)
	for i = 0, Self_GroupMembers, 1 do
		memberToTest			= Self_GroupMode .. tostring(i);
		membersTarget			= Self_GroupMode .. tostring(i) .. "target";
		membersPetToTest		= Self_GroupMode .."pet" .. tostring(i);
		membersPetTarget		= Self_GroupMode .."pet" .. tostring(i) .. "target";
		
		-- IDs in Raids start with 1, and include the player. But in partys the player is not included and has to be testet separately.
		if ((i == 0) and (Self_GroupMode == "party")) then
			memberToTest		= "player";
			membersTarget		= "target";
			membersPetToTest	= "pet";
			membersPetTarget	= "pettarget";
		end
		
		-- count members in party and if they target "unit"
		-- do pass i == 0 only when in party AND count yourself only if setting turned on
		if (((i ~= 0) or (Self_GroupMode == "party")) and ((not alias_UnitIsUnit(memberToTest, "player")) or get_SavedVariables("Count_SelfOwnPet"))) then
			class, armorType	= MTLove_UnitToClassAndArmorType(memberToTest);
			unitClassification	= "";
			memberIsTank		= MTLove_UnitIsTank(memberToTest, true);
			
			if (get_SavedVariables("Classify_by_ArmorType")) then
				unitClassification	= armorType;
			else
				unitClassification	= class;
			end
			
			if (memberIsTank and get_SavedVariables("Count_TANK")) then
				if (typesInGroup["TANK"] == nil) then
					typesInGroup["TANK"] = 1;
				else
					typesInGroup["TANK"] = typesInGroup["TANK"] + 1;
				end
				if (alias_UnitIsUnit(unit, membersTarget)) then
					if (typesTargetingUnit["TANK"] == nil) then
						typesTargetingUnit["TANK"] = 1;
					else
						typesTargetingUnit["TANK"] = typesTargetingUnit["TANK"] + 1;
					end
				end
			else
				if (unitClassification and unitClassification ~= "") then
					if (typesInGroup[unitClassification] == nil) then
						typesInGroup[unitClassification] = 1;
					else
						typesInGroup[unitClassification] = typesInGroup[unitClassification] + 1;
					end
					if (alias_UnitIsUnit(unit, membersTarget)) then
						if (typesTargetingUnit[unitClassification] == nil) then
							typesTargetingUnit[unitClassification] = 1;
						else
							typesTargetingUnit[unitClassification] = typesTargetingUnit[unitClassification] + 1;
						end
					end
				end
			end
			-- pet of current player
			if (alias_UnitExists(membersPetToTest) and get_SavedVariables("Count_PET")) then
				if (typesInGroup["PET"] == nil) then
					typesInGroup["PET"] = 1;
				else
					typesInGroup["PET"] = typesInGroup["PET"] + 1;
				end
				if (alias_UnitIsUnit(unit, membersPetTarget)) then
					if (typesTargetingUnit["PET"] == nil) then
						typesTargetingUnit["PET"] = 1;
					else
						typesTargetingUnit["PET"] = typesTargetingUnit["PET"] + 1;
					end
				end
			end
		end
	end
	
	-- building the counter string
	local sort_order;
	local colors;
	local number_of_unseparated		= 0;
	local unseparatedTargetingUnit	= 0;
	local count_result_tank			= "";
	local count_result_middle		= "";
	local count_result_pet			= "";
	local count_result				= "";
	
	if (get_SavedVariables("Classify_by_ArmorType")) then
		sort_order					= armorType_sort_order;
		colors						= armorType_colors;
	else
		sort_order					= class_sort_order;
		colors						= class_colors;
	end
	
	local thisTypeInGroup		= 0;
	local thisTypeTargetingUnit	= 0;
	local tmpResult				= "";
	
	-- iterate over all known types
	for i, _type in pairs(sort_order) do
		thisTypeInGroup				= 0;
		thisTypeTargetingUnit		= 0;
		if (typesInGroup[_type] ~= nil) then
			thisTypeInGroup			= typesInGroup[_type];
		end
		if (typesTargetingUnit[_type] ~= nil) then
			thisTypeTargetingUnit	= typesTargetingUnit[_type];
		end
		if (thisTypeInGroup > 0) then
			if (get_SavedVariables("Count_" .. _type)) then
				tmpResult	= string.format("|cff%02x%02x%02x", colors[_type].r * 255, colors[_type].g * 255, colors[_type].b * 255) .. thisTypeTargetingUnit .. end_color;
				if (_type == "TANK") then
					count_result_tank		= tmpResult;
				elseif (_type == "PET") then
					count_result_pet		= tmpResult;
				else
					if (count_result_middle ~= "") then
						count_result_middle			= count_result_middle .. " ";
					end
					count_result_middle			= count_result_middle .. tmpResult;
				end
			else
				number_of_unseparated		= number_of_unseparated + thisTypeInGroup;
				unseparatedTargetingUnit	= unseparatedTargetingUnit + thisTypeTargetingUnit;
			end
		end
	end
	if (count_result_tank ~= "") then
		count_result	= count_result_tank;
	end
	if (count_result_middle ~= "") then
		if (count_result_tank ~= "") then
			count_result	= count_result .. " : ";
		end
		count_result	= count_result .. count_result_middle;
	end
	if (count_result_pet ~= "") then
		if (count_result ~= "") then
			count_result	= count_result .. " : ";
		end
		count_result	= count_result .. count_result_pet;
	end
	if (number_of_unseparated > 0) then
		if (count_result ~= "") then
			count_result	= count_result .. " : ";
		end
		count_result		= count_result .. string.format("|cff%02x%02x%02x", color_unseparated.r * 255, color_unseparated.g * 255, color_unseparated.b * 255) .. unseparatedTargetingUnit .. end_color;
	end
	MTLove_Update_Memory_Usage();
	return count_result;
end

-- also initializes data field
function MTLove_Stats_Reset()
	stats_data["count_cpu"]		= 0;
	stats_data["cpu_average"]	= 0;
	stats_data["cpu_values"]	= 0;
	stats_data["cpu_max"]		= 0;
	stats_data["cpu_min"]		= 0;
	stats_data["count_mem"]		= 0;
	stats_data["mem_average"]	= 0;
	stats_data["mem_values"]	= 0;
	stats_data["mem_max"]		= 0;
	stats_data["mem_min"]		= 0;
end

function MTLove_Update_CPU_Usage()
	if (get_Stats()) then
		if (stats_data["count_cpu"]		>= do_stats_at_count) then
			stats_data["count_cpu"]		= 0;
			UpdateAddOnCPUUsage();
			local usedTime				= ceil(GetAddOnCPUUsage("MTLove") * 1000);
			stats_data["cpu_average"]	= ((stats_data["cpu_average"] * stats_data["cpu_values"]) + usedTime) / (stats_data["cpu_values"] + 1);
			stats_data["cpu_values"]	= stats_data["cpu_values"] + 1;
			if (usedTime > stats_data["cpu_max"]) then
				stats_data["cpu_max"]	= usedTime;
			end
			if ((usedTime < stats_data["cpu_min"]) or (stats_data["cpu_min"] == 0)) then
				stats_data["cpu_min"]	= usedTime;
			end
			MTLove_set_Stats_CPU_Usage("max: " .. stats_data["cpu_max"] .. " ns | average: " .. ceil(stats_data["cpu_average"]) .. " ns | min: " .. stats_data["cpu_min"] .. " ns");
		else
			stats_data["count_cpu"]		= stats_data["count_cpu"] +1;
		end
	end
end

function MTLove_Reset_CPU_Usage()
	if (get_Stats()) then
		ResetCPUUsage();
	end
end

function MTLove_Update_Memory_Usage()
	if (get_Stats()) then
		if (stats_data["count_mem"]		>= (do_stats_at_count + 1)) then
			stats_data["count_mem"]		= 0;
			UpdateAddOnMemoryUsage();
			local usedMem = ceil(GetAddOnMemoryUsage("MTLove"));
			stats_data["mem_average"]	= ((stats_data["mem_average"] * stats_data["mem_values"]) + usedMem) / (stats_data["mem_values"] + 1);
			stats_data["mem_values"]	= stats_data["mem_values"] + 1;				
			if (usedMem > stats_data["mem_max"])then
				stats_data["mem_max"]	= usedMem;
			end
			if ((usedMem < stats_data["mem_min"]) or (stats_data["mem_min"] == 0))  then
				stats_data["mem_min"]	= usedMem;
			end
			MTLove_set_Stats_Memory_Usage("max: " .. stats_data["mem_max"] .. " KB | average: " .. ceil(stats_data["mem_average"]) .. " KB | min: " .. stats_data["mem_min"] .. " KB");
		else
		stats_data["count_mem"]			= stats_data["count_mem"] + 1;
		end
	end
end
