--[[	MTLove 2 is a 'small' World Of Warcraft Addon which adds
		a "target of mouseover" function to the client.
		Copyright (C) 2006-2013 Herrmann, Tom
		from Randoom.org

	edit by malfdawg	This file is part of MTLove 2.

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

if (MTLove_UI_Localization) then
	if (MTLove_UI_Localization ~= "default") then
		MTLove_set_globalValue_UI_ClientLanguage(MTLove_UI_Localization);
	end
	MTLove_Local();
end

function MTLove_GUI_reset_to_defaults()
	MTLove_reset_to_defaults();
	MTLove_UI_playSound(true);
	MTLove_set_GUI_Settings_changed(nil);
	MTLove_GUI_refresh();
	MTLove_activate();
	MTLove_UI_PostStatus("defaults");
end

function MTLove_UI_playSound(set)
	local sound	= "igMainMenuOptionCheckBoxOff";
	if (set) then
		sound 	= "igMainMenuOptionCheckBoxOn";
	end
	PlaySound(sound);
end

function MTLove_UI_PostStatus(id)
	local msg	= "";
	if (id == "onload") then
		msg		= MTLove_UI_OnLoad;
		if (MTLove_get_globalValues("Version_PreRelease")) then
			msg	= msg .. MTLove_UI_Testversion;
			MTLove_GUI_About_Panel_SubText_Text = MTLove_GUI_About_Panel_SubText_Text .. MTLove_UI_Testversion;
		else
			msg	= msg .. MTLove_UI_Releaseversion;
			MTLove_GUI_About_Panel_SubText_Text = MTLove_GUI_About_Panel_SubText_Text .. MTLove_UI_Releaseversion;
		end
	elseif (id == "variables_loaded") then
		msg = MTLove_UI_Variables_Loaded;
	elseif (id == "defaults") then
		msg = MTLove_UI_Defaults;
	elseif (id == "old_version_defaults") then
		msg = MTLove_UI_OldVersionDefaults;
	elseif (id == "garbageclean") then
		msg = MTLove_UI_GarbageClean;
	end
	if (not (msg == nil)) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end

	--MTLove_UI_Debug("msg", msg);
end

function MTLove_UI_Debug(msg0, msg1)
	DEFAULT_CHAT_FRAME:AddMessage(string.sub(tostring(ceil(GetTime() * 1000)), 4, 6) .. " MTLove_UI_Debug: " .. tostring(msg0) .. " == " .. tostring(msg1));
end

function MTLove_GUI_onLoad(frame)
	if (frame == _G["MTLove_GUI_General_Options_Panel"]) then
		frame.name		= MTLove_GUI_General_Options_Category_Text;
		frame.okay		= function (frame) MTLove_GUI_getChanges(); end;
		frame.cancel	= function (frame) MTLove_set_GUI_Settings_changed(nil); end;
	else
		if (frame == _G["MTLove_GUI_Unit_Selection_Panel"]) then
			frame.name	= MTLove_GUI_Unit_Selection_Category_Text;
		elseif(frame == _G["MTLove_GUI_Counters_Panel"]) then
			frame.name	= MTLove_GUI_Counters_Category_Text;
		else
			frame.name	= MTLove_GUI_About_Category_Text;
		end
		frame.parent	= MTLove_GUI_General_Options_Category_Text;
	end
	frame.default		= function (frame) MTLove_GUI_reset_to_defaults(); end;
	InterfaceOptions_AddCategory(frame);
end

function MTLove_GUI_show()
	InterfaceOptionsFrame_OpenToCategory(MTLove_GUI_General_Options_Category_Text);
end

function MTLove_GUI_getChanges()
	if (MTLove_get_GUI_Settings_changed()) then
	
		-- try to get button state for any possible setting
		for setting in pairs(MTLove_get_generalDefaults()) do
			if (string.sub(setting, 1, 13) == "Frame_Offset_") then
				MTLove_set_SavedVariables(setting, _G["MTLove_GUI_Slider_" .. setting]:GetValue());
			else
				MTLove_set_SavedVariables(setting, _G["MTLove_GUI_BT_" .. setting]:GetChecked());
			end
		end
		
		-- and get state from buttons for non-permanent settings
		MTLove_set_Stats(MTLove_GUI_BT_About_Stats:GetChecked());
	end
	MTLove_set_GUI_Settings_changed(nil);
end

function MTLove_GUI_refresh()
	if (not MTLove_get_GUI_Settings_changed()) then
		-- try to set button state for any possible setting
		for setting in pairs(MTLove_get_generalDefaults()) do
			if (string.sub(setting, 1, 13) == "Frame_Offset_") then
				_G["MTLove_GUI_Slider_" .. setting]:SetValue(MTLove_get_SavedVariables(setting));
			else
				--MTLove_UI_Debug("Button", "MTLove_GUI_BT_" .. setting);
				_G["MTLove_GUI_BT_" .. setting]:SetChecked(MTLove_get_SavedVariables(setting));
			end
		end
		-- and set state for buttons from non-permanent settings
		MTLove_GUI_BT_About_Stats:SetChecked(MTLove_get_Stats());
		
	end
	if (MTLove_GUI_BT_Frame:GetChecked()) then
		MTLove_GUI_BT_Frame_Counter:Enable();
		MTLove_GUI_BT_Frame_Mo_Bar:Enable();
		MTLove_GUI_BT_Frame_Mot_Bar:Enable();
		MTLove_GUI_BT_Offset_Reset:Enable();
	else
		MTLove_GUI_BT_Frame_Counter:Disable();
		MTLove_GUI_BT_Frame_Mo_Bar:Disable();
		MTLove_GUI_BT_Frame_Mot_Bar:Disable();
		MTLove_GUI_BT_Offset_Reset:Disable();
	end
	if (MTLove_GUI_BT_TT:GetChecked()) then
		MTLove_GUI_BT_TT_Counter:Enable();
	else
		MTLove_GUI_BT_TT_Counter:Disable();
	end
	if ((MTLove_GUI_BT_Frame:GetChecked() and MTLove_GUI_BT_Frame_Counter:GetChecked()) or (MTLove_GUI_BT_TT:GetChecked() and MTLove_GUI_BT_TT_Counter:GetChecked()) or MTLove_GUI_BT_TargetCounter:GetChecked() or MTLove_GUI_BT_FocusCounter:GetChecked()) then
		for setting in pairs(MTLove_get_generalDefaults()) do
			if (string.sub(setting, 1, 6) == "Count_") then
				_G["MTLove_GUI_BT_" .. setting]:Enable();
			end
		end
	else
		for setting in pairs(MTLove_get_generalDefaults()) do
			if (string.sub(setting, 1, 6) == "Count_") then
				_G["MTLove_GUI_BT_" .. setting]:Disable();
			end
		end
	end
	
	local buttonIDsArmorType	= {"PLATE", "MAIL", "LEATHER", "CLOTH"};
	local buttonIDsClass		= {"WARRIOR", "DEATHKNIGHT", "PALADIN", "PRIEST", "SHAMAN", "DRUID", "ROGUE", "MAGE", "WARLOCK", "HUNTER"};
	if (MTLove_GUI_BT_Classify_by_ArmorType:GetChecked()) then
		MTLove_GUI_BT_Classify_by_Class:SetChecked(false);
		for i, str in pairs(buttonIDsArmorType) do
			_G["MTLove_GUI_BT_Count_" .. str]:Show();
		end
		for i, str in pairs(buttonIDsClass) do
			_G["MTLove_GUI_BT_Count_" .. str]:Hide();
		end
	else
		MTLove_GUI_BT_Classify_by_Class:SetChecked(true);
		for i, str in pairs(buttonIDsArmorType) do
			_G["MTLove_GUI_BT_Count_" .. str]:Hide();
		end
		for i, str in pairs(buttonIDsClass) do
			_G["MTLove_GUI_BT_Count_" .. str]:Show();
		end
	end
	if (MTLove_get_globalValues("Version_PreRelease")) then
		MTLove_GUI_BT_About_Stats:Show();
		MTLove_GUI_FS_About_StatsPerformance:Show();
		MTLove_GUI_FS_About_Stats_Cpu:Show();
		MTLove_GUI_FS_About_Stats_Mem:Show();
		if (not MTLove_GUI_BT_About_Stats:GetChecked()) then
			MTLove_Stats_Reset();
		end
	else
		MTLove_GUI_BT_About_Stats:Hide();
		MTLove_GUI_FS_About_StatsPerformance:Hide();
		MTLove_GUI_FS_About_Stats_Cpu:Hide();
		MTLove_GUI_FS_About_Stats_Mem:Hide();
	end
	if (MTLove_GUI_BT_About_Stats:GetChecked()) then
		MTLove_GUI_FS_About_Stats_Cpu:SetText(MTLove_GUI_FS_About_Stats_Cpu_Text .. " " .. MTLove_get_Stats_CPU_Usage());
		MTLove_GUI_FS_About_Stats_Mem:SetText(MTLove_GUI_FS_About_Stats_Mem_Text .. " " .. MTLove_get_Stats_Memory_Usage());
	else
		MTLove_GUI_FS_About_Stats_Cpu:SetText(MTLove_GUI_FS_About_Stats_Cpu_Text .. " " .. MTLove_GUI_Disabled);
		MTLove_GUI_FS_About_Stats_Mem:SetText(MTLove_GUI_FS_About_Stats_Mem_Text .. " " .. MTLove_GUI_Disabled);
		
	end
end
