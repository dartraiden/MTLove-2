--[[	MTLove 2 is a 'small' World Of Warcraft Addon which adds
		a "target of mouseover" function to the client.
		Copyright (C) 2006-2013 Herrmann, Tom
		from Randoom.org edited by malfdawg and dartraiden.

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

MTLove_SavedVariables								= {};
local MTLove_SavedVariables_Cache					= {};
local MTLove_SavedVariables_generalDefaults			= {
														["Frame"]							= true,
														["Frame_Counter"]					= false,
														["Frame_Mo_Bar"]					= false,
														["Frame_Mot_Bar"]					= false,
														["Frame_Offset_X"]					= 20,
														["Frame_Offset_Y"]					= -27,
														["TT"]								= false,
														["TT_Counter"]						= false,
														["Classify_by_ArmorType"]			= false,
														["Self_NotInParty"]					= true,
														["Mo_OutOfCombat"]					= true,
														["Mot_Highlight"]					= true,
														["Mo_Friendly_PartyMember_Player"]	= true,
														["Mo_Friendly_PartyMember_Pet"]		= true,
														["Mo_Friendly_Player"]				= true,
														["Mo_Friendly_Pet"]					= true,
														["Mo_Friendly_Npc"]					= true,
														["Mo_Enemy_Player"]					= true,
														["Mo_Enemy_Pet"]					= true,
														["Mo_Enemy_Npc"]					= true,
														["Mo_Neutral_Npc"]					= true,
														["Mot_Self"]						= true,
														["Mot_OwnPet"]						= true,
														["Mot_Friendly_PartyMember_Player"]	= true,
														["Mot_Friendly_PartyMember_Pet"]	= true,
														["Mot_Friendly_Player"]				= true,
														["Mot_Friendly_Pet"]				= true,
														["Mot_Friendly_Npc"]				= true,
														["Mot_Enemy_Player"]				= true,
														["Mot_Enemy_Pet"]					= true,
														["Mot_Enemy_Npc"]					= true,
														["Mot_Neutral_Npc"]					= true,
														["Mot_Stun"]						= false,
														["Mot_Mo_Self"]						= true,
														["Mot_Nothing"]						= false,
														["TargetCounter"]					= false,
														["FocusCounter"]					= false,
														["Count_SelfOwnPet"]				= false,
														["Count_PET"]						= false,
														["Count_TANK"]						= true,
														["Count_WARRIOR"]					= true,
														["Count_DEATHKNIGHT"]				= true,
														["Count_PALADIN"]					= true,
														["Count_PRIEST"]					= true,
														["Count_SHAMAN"]					= true,
														["Count_DRUID"]						= true,
														["Count_ROGUE"]						= true,
														["Count_MAGE"]						= true,
														["Count_WARLOCK"]					= true,
														["Count_HUNTER"]					= true,
														["Count_PLATE"]						= true,
														["Count_MAIL"]						= true,
														["Count_LEATHER"]					= true,
														["Count_CLOTH"]						= true,
														["Experimental_Features"]			= false
													};
local MTLove_SavedVariables_petHandlerDefaults		= {
														["Mot_OwnPet"]						= true,
														["Mot_Friendly_PartyMember_Pet"]	= true,
														["Count_PET"]						= true
													};
local MTLove_globalValues							= {};
MTLove_globalValues["UI_Name"]						= GetAddOnMetadata("MTLove", "Title");
MTLove_globalValues["UI_ClientLanguage"]			= GetLocale();
MTLove_globalValues["UI_Version"]					= GetAddOnMetadata("MTLove", "Version");
MTLove_globalValues["UI_Issues"]					= GetAddOnMetadata("MTLove", "X-Website") .. "/issues";
MTLove_globalValues["UI_Website"]					= GetAddOnMetadata("MTLove", "X-Website");
MTLove_globalValues["Version_Major"]				= string.sub(MTLove_globalValues["UI_Version"], 1, 1);
MTLove_globalValues["Version_Minor"]				= string.sub(MTLove_globalValues["UI_Version"], 3, 3);
MTLove_globalValues["Version_SubMinor"]				= string.sub(MTLove_globalValues["UI_Version"], 5);
MTLove_globalValues["Version_PreRelease"]			= (string.len(MTLove_globalValues["Version_SubMinor"]) > 3);
MTLove_globalValues["Frame_Offset_Slider_Low"]		= -200;
MTLove_globalValues["Frame_Offset_Slider_High"]		= 200;
MTLove_globalValues["UI_Frame_Offset_Slider_Low"]	= tostring(MTLove_globalValues["Frame_Offset_Slider_Low"]);
MTLove_globalValues["UI_Frame_Offset_Slider_High"]	= tostring(MTLove_globalValues["Frame_Offset_Slider_High"]);
local MTLove_Stats									= nil;
local MTLove_Stats_CPU_Usage						= "";
local MTLove_Stats_Memory_Usage						= "";
local MTLove_GUI_Settings_changed					= nil;

function MTLove_get_SavedVariables(setting)
	if (setting ~= nil) then
		if (MTLove_SavedVariables_Cache[setting]) then
			return MTLove_SavedVariables_Cache[setting];
		else
			if (string.sub(setting, 1, 13) == "Frame_Offset_") then
				return 0;
			end
			return nil;
		end
	end
	return MTLove_SavedVariables_Cache;
end
function MTLove_set_SavedVariables(setting, value)
	if (string.sub(setting, 1, 13) == "Frame_Offset_") then
		if (tonumber(value) ~= 0) then
			value	= tonumber(value);
		else
			value	= nil;
		end
	end
	MTLove_SavedVariables_Cache[setting]		= value;
	MTLove_SavedVariables["MTLove_" .. setting]	= MTLove_SavedVariables_Cache[setting];
end

function MTLove_get_generalDefaults()
	return MTLove_SavedVariables_generalDefaults;
end

function MTLove_get_globalValues(setting)
	if (setting ~= nil) then
		return MTLove_globalValues[setting];
	end
	return MTLove_globalValues;
end
function MTLove_set_globalValue_UI_ClientLanguage(UI_ClientLanguage)
	MTLove_globalValues["UI_ClientLanguage"]	= UI_ClientLanguage;
end

function MTLove_set_Stats(stats)
	MTLove_Stats = stats;
end
function MTLove_get_Stats()
	return MTLove_Stats;
end

function MTLove_set_Stats_CPU_Usage(CPU_Usage)
	MTLove_Stats_CPU_Usage = CPU_Usage;
end
function MTLove_get_Stats_CPU_Usage()
	return MTLove_Stats_CPU_Usage;
end

function MTLove_set_Stats_Memory_Usage(Memory_Usage)
	MTLove_Stats_Memory_Usage = Memory_Usage;
end
function MTLove_get_Stats_Memory_Usage()
	return MTLove_Stats_Memory_Usage;
end

function MTLove_set_GUI_Settings_changed(Settings_changed)
	MTLove_GUI_Settings_changed = Settings_changed;
end
function MTLove_get_GUI_Settings_changed()
	return MTLove_GUI_Settings_changed;
end

function MTLove_loadVariables()
	if (MTLove_tcount(MTLove_SavedVariables) == 0) then
		MTLove_SavedVariables = {};
		MTLove_GUI_reset_to_defaults();
	end

-- disable in 2.5.1
	if ((tonumber(MTLove_SavedVariables["MTLove_Version_Major"]) == 2) and (tonumber(MTLove_SavedVariables["MTLove_Version_Minor"]) == 3)) then
		-- convert settings
		if (MTLove_SavedVariables["MTLove_Count_Tanks"]) then
			MTLove_set_SavedVariables("Count_TANK", true);
		end
		if (MTLove_SavedVariables["MTLove_Count_Plate"]) then
			MTLove_set_SavedVariables("Count_PLATE", true);
			MTLove_set_SavedVariables("Count_WARRIOR", true);
			MTLove_set_SavedVariables("Count_DEATHKNIGHT", true);
			MTLove_set_SavedVariables("Count_PALADIN", true);
		end
		if (MTLove_SavedVariables["MTLove_Count_Mail"]) then
			MTLove_set_SavedVariables("Count_MAIL", true);
			MTLove_set_SavedVariables("Count_SHAMAN", true);
			MTLove_set_SavedVariables("Count_HUNTER", true);
		end
		if (MTLove_SavedVariables["MTLove_Count_Leather"]) then
			MTLove_set_SavedVariables("Count_LEATHER", true);
			MTLove_set_SavedVariables("Count_DRUID", true);
			MTLove_set_SavedVariables("Count_ROGUE", true);
		end
		if (MTLove_SavedVariables["MTLove_Count_Plate"] and MTLove_SavedVariables["MTLove_Count_Mail"] and MTLove_SavedVariables["MTLove_Count_Leather"]) then
			MTLove_set_SavedVariables("Count_CLOTH", true);
			MTLove_set_SavedVariables("Count_PRIEST", true);
			MTLove_set_SavedVariables("Count_MAGE", true);
			MTLove_set_SavedVariables("Count_WARLOCK", true);
		end
		if (MTLove_SavedVariables["MTLove_Count_Pets"]) then
			MTLove_set_SavedVariables("Count_PET", true);
		end
		if (MTLove_SavedVariables["MTLove_Mot_Healer_Highlight"]) then
			MTLove_set_SavedVariables("Mot_Highlight", true);
		end
	elseif (not MTLove_SavedVariables["MTLove_Version_Major"] or ((tonumber(MTLove_SavedVariables["MTLove_Version_Major"]) <= 2) and (tonumber(MTLove_SavedVariables["MTLove_Version_Minor"]) <= 3))) then
		-- too old for conversion hassle -> full reset
		MTLove_reset_to_defaults();
		MTLove_UI_PostStatus("old_version_defaults");
	end
-- /disable in 2.5.1

	-- try to load saved variable for any possible setting
	for setting in pairs(MTLove_SavedVariables_generalDefaults) do
		if (MTLove_SavedVariables["MTLove_" .. setting]) then
			MTLove_SavedVariables_Cache[setting]	= MTLove_SavedVariables["MTLove_" .. setting];
		end
	end

	if ((MTLove_SavedVariables["MTLove_Version_Major"] ~= MTLove_globalValues["Version_Major"]) or (MTLove_SavedVariables["MTLove_Version_Minor"] ~= MTLove_globalValues["Version_Minor"]) or (MTLove_SavedVariables["MTLove_Version_SubMinor"] ~= MTLove_globalValues["Version_SubMinor"])) then
		MTLove_UI_PostStatus("garbageclean");
		MTLove_GarbageClean_SavedVariables();
	end
end

-- reset all (saved) variables to their defaults
-- clears the settings cache, loads defaults into the cache and cleans up all saved variables
function MTLove_reset_to_defaults()
	MTLove_SavedVariables_Cache	= nil;
	MTLove_SavedVariables_Cache	= {};
	
	for setting, value in pairs(MTLove_SavedVariables_generalDefaults) do
		if (value) then
			MTLove_SavedVariables_Cache[setting]	= value;
		end
	end
	
	if (MTLove_UnitCanControlPet("player")) then
		for setting, value in pairs(MTLove_SavedVariables_petHandlerDefaults) do
			if (value) then
				MTLove_SavedVariables_Cache[setting]	= value;
			else
				MTLove_SavedVariables_Cache[setting]	= nil;
			end
		end
	end
	
	MTLove_GarbageClean_SavedVariables();
end

-- clean up saved variables
-- works by deleting all saved variables and then saves any setting from the cache
function MTLove_GarbageClean_SavedVariables()
	MTLove_SavedVariables								= nil;
	MTLove_SavedVariables								= {};
	MTLove_SavedVariables["MTLove_Version_Major"]		= MTLove_globalValues["Version_Major"];
	MTLove_SavedVariables["MTLove_Version_Minor"]		= MTLove_globalValues["Version_Minor"];
	MTLove_SavedVariables["MTLove_Version_SubMinor"]	= MTLove_globalValues["Version_SubMinor"];
	MTLove_SavedVariables["MTLove_Version_PreRelease"]	= MTLove_globalValues["Version_PreRelease"];
	
	-- "resave" setting from cache
	for setting in pairs(MTLove_SavedVariables_Cache) do
		MTLove_set_SavedVariables(setting, MTLove_get_SavedVariables(setting));
	end
end

function MTLove_tcount(tab)
	local n = 0;
		for _ in pairs(tab) do
			n = n + 1;
		end
	return n;
end
