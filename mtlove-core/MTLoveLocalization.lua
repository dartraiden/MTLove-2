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

local MTLove_UI_CMD_prefix							= "MTLove 2: ";
MTLove_GUI_License									= MTLove_get_globalValues("UI_Name") .. " is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License version 2 as published by the Free Software Foundation.\n\n" .. MTLove_get_globalValues("UI_Name") .. " is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.";

MTLove_UI_OnLoad									= MTLove_get_globalValues("UI_Name") .. " v" .. MTLove_get_globalValues("UI_Version") .. " by Herrmann, Tom from Randoom.org, edited by malfdawg and dartraiden.";
MTLove_UI_Releaseversion							= "\nPlease send your feedback to " .. MTLove_get_globalValues("UI_Issues") .. " and/or visit the project page at " .. MTLove_get_globalValues("UI_Website");
MTLove_UI_Testversion								= "\nPlease report any bugs of this test version to " .. MTLove_get_globalValues("UI_Issues") .. " and visit " .. MTLove_get_globalValues("UI_Website") .. " for updates.";
MTLove_UI_Variables_Loaded							= MTLove_UI_CMD_prefix .. "Settings for " .. UnitName("player") .. " of " .. GetRealmName() .. " loaded.";
MTLove_UI_Defaults									= MTLove_UI_CMD_prefix .. "Defaults for all settings loaded.";
MTLove_UI_OldVersionDefaults						= MTLove_UI_CMD_prefix .. "Previous version too old for settings conversion. Defaults for all settings loaded.";
MTLove_UI_GarbageClean								= MTLove_UI_CMD_prefix .. "You recently updated " .. MTLove_get_globalValues("UI_Name") .. ".\n" .. MTLove_UI_CMD_prefix .. "Your settings were cleaned.";
MTLove_UI_FearStun									= "feared/stunned";
MTLove_UI_Mot_Mo_Self								= "itself";
MTLove_UI_Mot_Nothing								= "nothing";
MTLove_UI_Level										= "Level";
MTLove_UI_Self										= "yourself";
MTLove_UI_Player									= "Player";
MTLove_UI_OwnPet									= "(your Pet)";
MTLove_UI_Pet										= "Pet";
MTLove_UI_NPC										= "Npc";
MTLove_UI_Boss										= "BOSS";
MTLove_GUI_General_Options_Category_Text			= MTLove_get_globalValues("UI_Name");
MTLove_GUI_General_Options_Panel_Title_Text			= MTLove_get_globalValues("UI_Name") .. " - General Options";
MTLove_GUI_General_Options_Panel_SubText_Text		= "These options allow you to control which main features of " .. MTLove_get_globalValues("UI_Name") .. " are used and visible within the game field while you play. Please note the '+'-button extending this category and read the 'Counters' section.";
MTLove_GUI_BT_Frame_Text							= "enable the frame";
MTLove_GUI_BT_Frame_Counter_Text					= "attach counter to the frame";
MTLove_GUI_BT_Frame_Mo_Bar_Text						= "attach Mouseover-HP-Bar"
MTLove_GUI_BT_Frame_Mot_Bar_Text					= "attach Mouseovertarget-HP-Bar"
MTLove_GUI_Slider_Frame_Offset_X_Text				= "frame offset X coordiate";
MTLove_GUI_Slider_Frame_Offset_Y_Text				= "frame offset Y coordiate";
MTLove_GUI_BT_Offset_Reset_Text						= "reset frame offset";
MTLove_GUI_BT_TT_Text								= "enable the tooltip";
MTLove_GUI_BT_TT_Counter_Text						= "attach counter to the tooltip";
MTLove_GUI_FS_Frame_TT_Options_Text					= "options for both the frame and the tooltip";
MTLove_GUI_BT_Self_NotInParty_Text					= "enable even if you are not in group/raid";
MTLove_GUI_BT_Mo_OutOfCombat_Text					= "enable even if your mouseover is out of combat";
MTLove_GUI_BT_Mot_Highlight_Text					= "special highlight if a tank or healer is the target of your mouseover";
MTLove_GUI_FS_UnitClassification_Text				= "classify (and colorize) by";
MTLove_GUI_BT_Classify_by_Class_Text				= "class (Warrior, Mage, etc)";
MTLove_GUI_BT_Classify_by_ArmorType_Text			= "armor type (Plate, Cloth, etc)";
MTLove_GUI_Unit_Selection_Category_Text				= "Unit Selection";
MTLove_GUI_Unit_Selection_Panel_Title_Text			= MTLove_get_globalValues("UI_Name") .. " - " .. MTLove_GUI_Unit_Selection_Category_Text;
MTLove_GUI_Unit_Selection_Panel_SubText_Text		= "These options allow you to change on which unit combination both the frame and the tooltip are active.";
MTLove_GUI_FS_Mo_Text								= "activate if one of the following units is your mouseover";
MTLove_GUI_FS_Mot_Text								= "AND it targets one of the following units";
MTLove_GUI_BT_Mot_Self_Text							= "yourself";
MTLove_GUI_BT_Mot_OwnPet_Text						= "your own pet";
MTLove_GUI_BT_Mot_Friendly_PartyMember_Player_Text	= "group/raid player";
MTLove_GUI_BT_Mot_Friendly_PartyMember_Pet_Text		= "group/raid pet";
MTLove_GUI_BT_Mot_Friendly_Player_Text				= "friendly player";
MTLove_GUI_BT_Mot_Friendly_Pet_Text					= "friendly pet";
MTLove_GUI_BT_Mot_Friendly_Npc_Text					= "friendly npc";
MTLove_GUI_BT_Mot_Enemy_Player_Text					= "enemy player";
MTLove_GUI_BT_Mot_Enemy_Pet_Text					= "enemy pet";
MTLove_GUI_BT_Mot_Enemy_Npc_Text					= "enemy npc";
MTLove_GUI_BT_Mot_Neutral_Npc_Text					= "neutral npc";
MTLove_GUI_FS_MotSpecial_Text						= "OR (it don't targets one of the above, but) the mouseover";
MTLove_GUI_BT_Mot_Stun_Text							= "is feared/stunned";
MTLove_GUI_BT_Mot_Mo_Self_Text						= "targets itself";
MTLove_GUI_BT_Mot_Nothing_Text						= "targets *nothing*";
MTLove_GUI_Counters_Category_Text					= "Counters";
MTLove_GUI_Counters_Panel_Title_Text				= MTLove_get_globalValues("UI_Name") .. " - " .. MTLove_GUI_Counters_Category_Text;
MTLove_GUI_Counters_Panel_SubText_Text				= "The counters display the number of group/raid players who have your mouseover, target and/or focus as target. Each target-'type' is counted separately, so you can track up to 3 different units.";
MTLove_GUI_FS_About_Counter_Perf_Head_Text			= "Note about counter performance";
MTLove_GUI_FS_About_Counter_Performance_Text		= "If you experience short freezes/spluttering graphics in combat, you should try to disable some or all counters, as they can waste a lot of performance. As larger the group/raid, as longer it takes to check all members and as more performance is wasted.";
MTLove_GUI_FS_ExtraCounters_Text					= "attach additional counters to";
MTLove_GUI_BT_TargetCounter_Text					= "the default target-frame";
MTLove_GUI_BT_FocusCounter_Text						= "the default focus-frame";
MTLove_GUI_FS_Counter_Options_Text					= "options for all counters";
MTLove_GUI_BT_Count_SelfOwnPet_Text					= "count yourself/your pet";
MTLove_GUI_BT_Count_PET_Text						= "count pets";
MTLove_GUI_BT_Count_TANK_Text						= "separate tanks";
MTLove_GUI_BT_Count_WARRIOR_Text					= "separate warriors";
MTLove_GUI_BT_Count_DEATHKNIGHT_Text				= "separate deathknights";
MTLove_GUI_BT_Count_PALADIN_Text					= "separate paladins";
MTLove_GUI_BT_Count_PRIEST_Text						= "separate priests";
MTLove_GUI_BT_Count_SHAMAN_Text						= "separate shamans";
MTLove_GUI_BT_Count_DRUID_Text						= "separate druids";
MTLove_GUI_BT_Count_ROGUE_Text						= "separate rogues";
MTLove_GUI_BT_Count_MAGE_Text						= "separate mages";
MTLove_GUI_BT_Count_WARLOCK_Text					= "separate warlocks";
MTLove_GUI_BT_Count_HUNTER_Text						= "separate hunters";
MTLove_GUI_BT_Count_PLATE_Text						= "separate plate wearers";
MTLove_GUI_BT_Count_MAIL_Text						= "separate mail wearers";
MTLove_GUI_BT_Count_LEATHER_Text					= "separate leather wearers";
MTLove_GUI_BT_Count_CLOTH_Text						= "separate cloth wearers";
MTLove_GUI_About_Category_Text						= "Other/About";
MTLove_GUI_About_Panel_Title_Text					= MTLove_get_globalValues("UI_Name") .. " - " .. MTLove_GUI_About_Category_Text;
MTLove_GUI_About_Panel_SubText_Text					= MTLove_UI_OnLoad;
MTLove_GUI_BT_About_Stats_Text						= "stats (test versions only):";
MTLove_GUI_FS_About_StatsPerformance_Text			= "This wastes some performance. Do not activate, if you don't have any real purpose for it. If the CPU value stays 0 after combat, add the following line to '*WOW-Folder*\\WTF\\Config.wtf':\nSET scriptProfile \"1\"";
MTLove_GUI_FS_About_Stats_Cpu_Text					= "CPU usage:";
MTLove_GUI_FS_About_Stats_Mem_Text					= "Memory usage:";
MTLove_GUI_Stats_Gathering							= "gathering stats";
MTLove_GUI_Disabled									= "DISABLED";
MTLove_GUI_BT_Experimental_Features_Text			= "experimental CT_RaidAssist support";

function MTLove_Local()
	if ((MTLove_get_globalValues("UI_ClientLanguage") ~= "enUS") and (MTLove_get_globalValues("UI_ClientLanguage") ~= "enGB")) then
		if (MTLove_get_globalValues("UI_ClientLanguage") == "deDE") then
			MTLove_UI_OnLoad									= MTLove_get_globalValues("UI_Name") .. " v" .. MTLove_get_globalValues("UI_Version") .. " von Herrmann, Tom von Randoom.org, bearbeitet von malfdawg und dartraiden.";
			MTLove_UI_Releaseversion							= "\nBitte senden Sie ihre Anmerkungen an " .. MTLove_get_globalValues("UI_Issues") .. " und/oder besuchen Sie die Projekt Seite " .. MTLove_get_globalValues("UI_Website");
			MTLove_UI_Testversion								= "\nBitte melden Sie alle Fehler dieser Test-Version an " .. MTLove_get_globalValues("UI_Issues") .. " und besuchen " .. MTLove_get_globalValues("UI_Website") .. " für Aktualisierungen.";
			MTLove_UI_Variables_Loaded							= MTLove_UI_CMD_prefix .. "Einstellungen für " .. UnitName("player") .. " auf " .. GetRealmName() .. " geladen.";
			MTLove_UI_Defaults									= MTLove_UI_CMD_prefix .. "Standards für alle Einstellungen geladen.";
			MTLove_UI_OldVersionDefaults						= MTLove_UI_CMD_prefix .. "Vorherige Version zu alt um Einstellungen zu konvertieren. Standards für alle Einstellungen geladen.";
			MTLove_UI_GarbageClean								= MTLove_UI_CMD_prefix .. "Sie haben vor kurzem " .. MTLove_get_globalValues("UI_Name") .. " aktualisiert.\n" .. MTLove_UI_CMD_prefix .. "Ihre Einstellungen wurden bereinigt.";
			MTLove_UI_FearStun									= "verjagt/betäubt";
			MTLove_UI_Mot_Mo_Self								= "sich selbst";
			MTLove_UI_Mot_Nothing								= "nichts";
			MTLove_UI_Level										= "Stufe";
			MTLove_UI_Self										= "Sie selbst";
			MTLove_UI_Player									= "Spieler";
			MTLove_UI_OwnPet									= "(ihr Begleiter)";
			MTLove_UI_Pet										= "Begleiter";
			MTLove_UI_NPC										= "Npc";
			MTLove_UI_Boss										= "BOSS";
			MTLove_GUI_General_Options_Category_Text			= MTLove_get_globalValues("UI_Name");
			MTLove_GUI_General_Options_Panel_Title_Text			= MTLove_get_globalValues("UI_Name") .. " - Allgemeine Optionen";
			MTLove_GUI_General_Options_Panel_SubText_Text		= "Diese Optionen erlauben einzustellen welche der Haupt-Funktionen von " .. MTLove_get_globalValues("UI_Name") .. " benutzt und in Spiel angezeigt werden. Bitte achten Sie auf den diese Kategorie erweiternden Plus-Knopf und die 'Zähler' Seite.";
			MTLove_GUI_BT_Frame_Text							= "Frame aktivieren";
			MTLove_GUI_BT_Frame_Counter_Text					= "Zähler am Frame aktivieren";
			MTLove_GUI_BT_Frame_Mo_Bar_Text						= "Mouseover-HP-Bar aktivieren"
			MTLove_GUI_BT_Frame_Mot_Bar_Text					= "Mouseover-Target-HP-Bar aktivieren"
			MTLove_GUI_Slider_Frame_Offset_X_Text				= "horizontales Frame Offset";
			MTLove_GUI_Slider_Frame_Offset_Y_Text				= "vertikales Frame Offset";
			MTLove_GUI_BT_Offset_Reset_Text						= "Offset zurücksetzen";
			MTLove_GUI_BT_TT_Text								= "ToolTip aktivieren";
			MTLove_GUI_BT_TT_Counter_Text						= "Zähler am ToolTip aktivieren";
			MTLove_GUI_FS_Frame_TT_Options_Text					= "Optionen für den Frame und den ToolTip";
			MTLove_GUI_BT_Self_NotInParty_Text					= "selbst wenn Sie in keiner (Schlacht-)Gruppe sind aktivieren";
			MTLove_GUI_BT_Mo_OutOfCombat_Text					= "selbst wenn sich ihr Mouseover nicht im Kampf befindet aktivieren";
			MTLove_GUI_BT_Mot_Highlight_Text					= "Hervorhebung wenn ein Tank oder Heiler das Ziel ihres Mouseovers ist";
			MTLove_GUI_FS_UnitClassification_Text				= "Klassifiziere (und koloriere) nach";
			MTLove_GUI_BT_Classify_by_Class_Text				= "Klasse (Krieger, Magier, usw)";
			MTLove_GUI_BT_Classify_by_ArmorType_Text			= "Rüstungstyp (Platte, Stoff, etc)";
			MTLove_GUI_Unit_Selection_Category_Text				= "Einheiten Auswahl";
			MTLove_GUI_Unit_Selection_Panel_Title_Text			= MTLove_get_globalValues("UI_Name") .. " - " .. MTLove_GUI_Unit_Selection_Category_Text;
			MTLove_GUI_Unit_Selection_Panel_SubText_Text		= "Diese Optionen erlauben ihnen zu verändern welche Einheiten Kombinationen den Frame und den ToolTip aktivieren.";
			MTLove_GUI_FS_Mo_Text								= "aktivieren wenn eine dieser Einheiten ihr Mouseovers ist";
			MTLove_GUI_FS_Mot_Text								= "UND eine der folgenden Einheiten sein Ziel ist";
			MTLove_GUI_BT_Mot_Self_Text							= "Sie selbst";
			MTLove_GUI_BT_Mot_OwnPet_Text						= "ihr Begleiter";
			MTLove_GUI_BT_Mot_Friendly_PartyMember_Player_Text	= "(Schlacht-)Gruppen\nSpieler";
			MTLove_GUI_BT_Mot_Friendly_PartyMember_Pet_Text		= "(Schlacht-)Gruppen\nBegleiter";
			MTLove_GUI_BT_Mot_Friendly_Player_Text				= "freundlicher Spieler";
			MTLove_GUI_BT_Mot_Friendly_Pet_Text					= "freundlicher\nBegleiter";
			MTLove_GUI_BT_Mot_Friendly_Npc_Text					= "freundlicher Npc";
			MTLove_GUI_BT_Mot_Enemy_Player_Text					= "feindlicher Spieler";
			MTLove_GUI_BT_Mot_Enemy_Pet_Text					= "feindlicher Begleiter";
			MTLove_GUI_BT_Mot_Enemy_Npc_Text					= "feindlicher Npc";
			MTLove_GUI_BT_Mot_Neutral_Npc_Text					= "neutraler Npc";
			MTLove_GUI_FS_MotSpecial_Text						= "ODER (auf keine d. oberen Einheiten zielt, aber) ihr Mouseover";
			MTLove_GUI_BT_Mot_Stun_Text							= "verjagdt/betäubt ist";
			MTLove_GUI_BT_Mot_Mo_Self_Text						= "auf sich selbst zielt";
			MTLove_GUI_BT_Mot_Nothing_Text						= "auf *nichts* zielt";
			MTLove_GUI_Counters_Category_Text					= "Zähler";
			MTLove_GUI_Counters_Panel_Title_Text				= MTLove_get_globalValues("UI_Name") .. " - " .. MTLove_GUI_Counters_Category_Text;
			MTLove_GUI_Counters_Panel_SubText_Text				= "Die Zähler zeigen die Anzahl der (Schlacht-)Gruppen Spieler, die ihr Mouseover, Ziel und/oder Fokus als Ziel haben. Jeder Ziel-'typ' wird einzeln gezählt, so das Sie 3 verschiedene Einheiten verfolgen können.";
			MTLove_GUI_FS_About_Counter_Perf_Head_Text			= "Anmerkungen über Zähler Leistung";
			MTLove_GUI_FS_About_Counter_Performance_Text		= "Wenn Sie kurze Standbilder/stotternde Grafik im Kampf haben, sollten Sie versuchen einige oder alle Zähler zu deaktivieren, da diese viel Leistung verbrauchen können. Je größer ihre (Schlacht-)Gruppe, je länger dauert es alle Mitglieder zu überprüfen und je mehr Leistung wird verbraucht.";
			MTLove_GUI_FS_ExtraCounters_Text					= "füge weitere Zähler an";
			MTLove_GUI_BT_TargetCounter_Text					= "den Standard-Ziel-Frame"
			MTLove_GUI_BT_FocusCounter_Text						= "den Standard-Fokus-Frame"
			MTLove_GUI_FS_Counter_Options_Text					= "Optionen für alle Zähler";
			MTLove_GUI_BT_Count_SelfOwnPet_Text					= "zähle Sie selbst/ihren Begleiter";
			MTLove_GUI_BT_Count_PET_Text						= "zähle Begleiter";
			MTLove_GUI_BT_Count_TANK_Text						= "separiere Tanks";
			MTLove_GUI_BT_Count_WARRIOR_Text					= "separiere Krieger";
			MTLove_GUI_BT_Count_DEATHKNIGHT_Text				= "separiere Todesritter";
			MTLove_GUI_BT_Count_PALADIN_Text					= "separiere Paladine";
			MTLove_GUI_BT_Count_PRIEST_Text						= "separiere Priester";
			MTLove_GUI_BT_Count_SHAMAN_Text						= "separiere Shamanen";
			MTLove_GUI_BT_Count_DRUID_Text						= "separiere Druiden";
			MTLove_GUI_BT_Count_ROGUE_Text						= "separiere Schurken";
			MTLove_GUI_BT_Count_MAGE_Text						= "separiere Magier";
			MTLove_GUI_BT_Count_WARLOCK_Text					= "separiere Hexenmeister";
			MTLove_GUI_BT_Count_HUNTER_Text						= "separiere Jäger";
			MTLove_GUI_BT_Count_PLATE_Text						= "separiere Plate Träger";
			MTLove_GUI_BT_Count_MAIL_Text						= "separiere Träger\nschwerer Rüstung";
			MTLove_GUI_BT_Count_LEATHER_Text					= "separiere Leder Träger";
			MTLove_GUI_BT_Count_CLOTH_Text						= "separiere Stoff Träger";
			MTLove_GUI_About_Category_Text						= "Weiteres/Über";
			MTLove_GUI_About_Panel_Title_Text					= MTLove_get_globalValues("UI_Name") .. " - " .. MTLove_GUI_About_Category_Text;
			MTLove_GUI_About_Panel_SubText_Text					= MTLove_UI_OnLoad;
			MTLove_GUI_BT_About_Stats_Text						= "Statistiken (nur Testversionen):";
			MTLove_GUI_FS_About_StatsPerformance_Text			= "Die Statistiken verschwenden etwas Leistung. Nicht aktivieren, wenn Sie keinen echten Grund dafür haben. Wenn der CPU Wert nach einem Kampf 0 bleibt, müssen Sie die folgene Zeile der '*WOW-Ordner*\\WTF\\Config.wtf'-Datei hinzufügen:\nSET scriptProfile \"1\"";
			MTLove_GUI_FS_About_Stats_Cpu_Text					= "CPU Nutzung:";
			MTLove_GUI_FS_About_Stats_Mem_Text					= "Memory Nutzung:";
			MTLove_GUI_Stats_Gathering							= "sammele Statistiken";
			MTLove_GUI_Disabled									= "DEAKTIVIERT";
			MTLove_GUI_BT_Experimental_Features_Text			= "experimentelle CT_RaidAssist Unterstützung";
		elseif (MTLove_get_globalValues("UI_ClientLanguage") == "ruRU") then
			MTLove_UI_OnLoad									= MTLove_get_globalValues("UI_Name") .. " v" .. MTLove_get_globalValues("UI_Version") .. " от Tom Herrmann с Randoom.org, с правками от malfdawg и dartraiden.";
			MTLove_UI_Releaseversion							= "\nПожалуйста, присылайте отзывы на " .. MTLove_get_globalValues("UI_Issues") .. " и/или посетите сайт проекта, расположенный по адресу " .. MTLove_get_globalValues("UI_Website");
			MTLove_UI_Testversion								= "\nПожалуйста, сообщайте об ошибках этой версии для тестирования на " .. MTLove_get_globalValues("UI_Issues") .. " и посетите " .. MTLove_get_globalValues("UI_Website") .. ", чтобы получить обновлённую версию.";
			MTLove_UI_Variables_Loaded							= MTLove_UI_CMD_prefix .. "Загружены настройки персонажа " .. UnitName("player") .. " с игрового мира " .. GetRealmName() .. ".";
			MTLove_UI_Defaults									= MTLove_UI_CMD_prefix .. "Загружены настройки по умолчанию.";
			MTLove_UI_OldVersionDefaults						= MTLove_UI_CMD_prefix .. "Предыдущая версия слишком стара, чтобы можно было преобразовать настройки в новый формат. Загружены настройки по умолчанию.";
			MTLove_UI_GarbageClean								= MTLove_UI_CMD_prefix .. "Вы недавно обновили " .. MTLove_get_globalValues("UI_Name") .. ".\n" .. MTLove_UI_CMD_prefix .. "Настройки очищены.";
			MTLove_UI_FearStun									= "испуган/оглушён";
			MTLove_UI_Mot_Mo_Self								= "он сам";
			MTLove_UI_Mot_Nothing								= "нет цели";
			MTLove_UI_Level										= "Уровень";
			MTLove_UI_Self										= "вы";
			MTLove_UI_Player									= "Игрок";
			MTLove_UI_OwnPet									= "(ваш питомец)";
			MTLove_UI_Pet										= "Питомец";
			MTLove_UI_NPC										= "НИП";
			MTLove_UI_Boss										= "БОСС";
			MTLove_GUI_General_Options_Category_Text			= MTLove_get_globalValues("UI_Name");
			MTLove_GUI_General_Options_Panel_Title_Text			= MTLove_get_globalValues("UI_Name") .. " - Основные настройки";
			MTLove_GUI_General_Options_Panel_SubText_Text		= "Эти настройки позволяют указать, какие возможности " .. MTLove_get_globalValues("UI_Name") .. " будут использоваться и показываться на экране. Учтите, что кнопка '+' раскрывает подменю, а также загляните в раздел настроек 'Счётчики'.";
			MTLove_GUI_BT_Frame_Text							= "включить индикатор";
			MTLove_GUI_BT_Frame_Counter_Text					= "показать счётчик";
			MTLove_GUI_BT_Frame_Mo_Bar_Text						= "показать индикатор здоровья персонажа, на которого наведён ваш курсор"
			MTLove_GUI_BT_Frame_Mot_Bar_Text					= "показать индикатор здоровья цели персонажа, на которого наведён курсор"
			MTLove_GUI_Slider_Frame_Offset_X_Text				= "смещение по горизонтали";
			MTLove_GUI_Slider_Frame_Offset_Y_Text				= "смещение по вертикали";
			MTLove_GUI_BT_Offset_Reset_Text						= "сбросить смещение индикатора";
			MTLove_GUI_BT_TT_Text								= "включить подсказку";
			MTLove_GUI_BT_TT_Counter_Text						= "показать счётчик";
			MTLove_GUI_FS_Frame_TT_Options_Text					= "общие настройки для индикатора и подсказки";
			MTLove_GUI_BT_Self_NotInParty_Text					= "включить, даже если вы не в группе/рейде";
			MTLove_GUI_BT_Mo_OutOfCombat_Text					= "включить, даже если персонаж, на которого наведён ваш курсор, не находится в бою";
			MTLove_GUI_BT_Mot_Highlight_Text					= "особая подсветка, если целью персонажа, на которого наведён ваш курсор, является танк или целитель";
			MTLove_GUI_FS_UnitClassification_Text				= "разделить (и раскрасить) по";
			MTLove_GUI_BT_Classify_by_Class_Text				= "классу (воин, маг и т. п.)";
			MTLove_GUI_BT_Classify_by_ArmorType_Text			= "типу брони (латы, ткань и т. п.)";
			MTLove_GUI_Unit_Selection_Category_Text				= "Выбор персонажа";
			MTLove_GUI_Unit_Selection_Panel_Title_Text			= MTLove_get_globalValues("UI_Name") .. " - " .. MTLove_GUI_Unit_Selection_Category_Text;
			MTLove_GUI_Unit_Selection_Panel_SubText_Text		= "Эти настройки позволяют выбрать персонажей, для которых будут показываться индикатор и подсказка.";
			MTLove_GUI_FS_Mo_Text								= "показать индикатор и подсказку, если персонажем, на которого наведён ваш курсор, является";
			MTLove_GUI_FS_Mot_Text								= "И его целью является один из следующих персонажей";
			MTLove_GUI_BT_Mot_Self_Text							= "вы";
			MTLove_GUI_BT_Mot_OwnPet_Text						= "ваш питомец";
			MTLove_GUI_BT_Mot_Friendly_PartyMember_Player_Text	= "член группы/рейда";
			MTLove_GUI_BT_Mot_Friendly_PartyMember_Pet_Text		= "питомец члена группы/рейда";
			MTLove_GUI_BT_Mot_Friendly_Player_Text				= "дружественный игрок";
			MTLove_GUI_BT_Mot_Friendly_Pet_Text					= "друж. питомец";
			MTLove_GUI_BT_Mot_Friendly_Npc_Text					= "дружественный НИП";
			MTLove_GUI_BT_Mot_Enemy_Player_Text					= "враждебный игрок";
			MTLove_GUI_BT_Mot_Enemy_Pet_Text					= "враж. питомец";
			MTLove_GUI_BT_Mot_Enemy_Npc_Text					= "враждебный НИП";
			MTLove_GUI_BT_Mot_Neutral_Npc_Text					= "нейтральный НИП";
			MTLove_GUI_FS_MotSpecial_Text						= "ИЛИ (он не выбрал целью никого из вышеперечисленных, но)";
			MTLove_GUI_BT_Mot_Stun_Text							= "испуган/оглушён";
			MTLove_GUI_BT_Mot_Mo_Self_Text						= "выбрал целью себя";
			MTLove_GUI_BT_Mot_Nothing_Text						= "не выбрал цель";
			MTLove_GUI_Counters_Category_Text					= "Счётчики";
			MTLove_GUI_Counters_Panel_Title_Text				= MTLove_get_globalValues("UI_Name") .. " - " .. MTLove_GUI_Counters_Category_Text;
			MTLove_GUI_Counters_Panel_SubText_Text				= "Счётчики показывают количество игроков в группе/рейде, которые выбрали своей целью персонажа, на которого наведён ваш курсор, вашу цель и/или вашу запомненную цель. Каждый 'тип' цели считается отдельно, поэтому вы можете одновременно отслеживать до 3 персонажей.";
			MTLove_GUI_FS_About_Counter_Perf_Head_Text			= "Предупреждение о производительности счётчиков";
			MTLove_GUI_FS_About_Counter_Performance_Text		= "Если, находясь в бою, вы столкнётесь с кратковременными зависаниями изображения, попробуйте отключить некоторые или все счётчики, поскольку они серьёзно влияют на производительность. Чем больше игроков состоит в группе/рейде, тем дольше занимает проверка всех игроков, и тем больше снижается производительность.";
			MTLove_GUI_FS_ExtraCounters_Text					= "прикрепить дополнительные счётчики";
			MTLove_GUI_BT_TargetCounter_Text					= "к стандартному окну цели";
			MTLove_GUI_BT_FocusCounter_Text						= "к стандартному окну запомненной цели";
			MTLove_GUI_FS_Counter_Options_Text					= "настройки для всех счётчиков";
			MTLove_GUI_BT_Count_SelfOwnPet_Text					= "считать вас/вашего питомца";
			MTLove_GUI_BT_Count_PET_Text						= "считать питомцев";
			MTLove_GUI_BT_Count_TANK_Text						= "отделять танков";
			MTLove_GUI_BT_Count_WARRIOR_Text					= "отделять воинов";
			MTLove_GUI_BT_Count_DEATHKNIGHT_Text				= "отделять рыцарей смерти";
			MTLove_GUI_BT_Count_PALADIN_Text					= "отделять паладинов";
			MTLove_GUI_BT_Count_PRIEST_Text						= "отделять жрецов";
			MTLove_GUI_BT_Count_SHAMAN_Text						= "отделять шаманов";
			MTLove_GUI_BT_Count_DRUID_Text						= "отделять друидов";
			MTLove_GUI_BT_Count_ROGUE_Text						= "отделять разбойников";
			MTLove_GUI_BT_Count_MAGE_Text						= "отделять магов";
			MTLove_GUI_BT_Count_WARLOCK_Text					= "отделять чернокнижников";
			MTLove_GUI_BT_Count_HUNTER_Text						= "отделять охотников";
			MTLove_GUI_BT_Count_PLATE_Text						= "отделять носящих латы";
			MTLove_GUI_BT_Count_MAIL_Text						= "отделять носящих кольчугу";
			MTLove_GUI_BT_Count_LEATHER_Text					= "отделять носящих кожу";
			MTLove_GUI_BT_Count_CLOTH_Text						= "отделять носящих ткань";
			MTLove_GUI_About_Category_Text						= "Прочее";
			MTLove_GUI_About_Panel_Title_Text					= MTLove_get_globalValues("UI_Name") .. " - " .. MTLove_GUI_About_Category_Text;
			MTLove_GUI_About_Panel_SubText_Text					= MTLove_UI_OnLoad;
			MTLove_GUI_BT_About_Stats_Text						= "статистика (только в версиях для тестирования):";
			MTLove_GUI_FS_About_StatsPerformance_Text			= "Это снижает производительность. Не включайте без реальной необходимости. Если значение 'Использование CPU' остаётся равным нулю после боя, добавьте в '*каталог WOW\\WTF\\Config.wtf' следующую строку:\nSET scriptProfile \"1\"";
			MTLove_GUI_FS_About_Stats_Cpu_Text					= "Использование CPU:";
			MTLove_GUI_FS_About_Stats_Mem_Text					= "Использование памяти:";
			MTLove_GUI_Stats_Gathering							= "сбор статистики";
			MTLove_GUI_Disabled									= "ОТКЛЮЧЁН";
			MTLove_GUI_BT_Experimental_Features_Text			= "экспериментальная поддержка CT_RaidAssist";
		else
			MTLove_UI_Variables_Loaded							= MTLove_UI_Variables_Loaded .. "\nThere is no localization for your language\nIf you want to help me to add or update it, please create an issue on " .. MTLove_get_globalValues("UI_Issues") .. ".\nThanks"
		end
	end
	MTLove_GUI_BT_Mo_Friendly_PartyMember_Player_Text	= MTLove_GUI_BT_Mot_Friendly_PartyMember_Player_Text;
	MTLove_GUI_BT_Mo_Friendly_PartyMember_Pet_Text		= MTLove_GUI_BT_Mot_Friendly_PartyMember_Pet_Text;
	MTLove_GUI_BT_Mo_Friendly_Player_Text				= MTLove_GUI_BT_Mot_Friendly_Player_Text;
	MTLove_GUI_BT_Mo_Friendly_Pet_Text					= MTLove_GUI_BT_Mot_Friendly_Pet_Text;
	MTLove_GUI_BT_Mo_Friendly_Npc_Text					= MTLove_GUI_BT_Mot_Friendly_Npc_Text	;
	MTLove_GUI_BT_Mo_Enemy_Player_Text					= MTLove_GUI_BT_Mot_Enemy_Player_Text;
	MTLove_GUI_BT_Mo_Enemy_Pet_Text						= MTLove_GUI_BT_Mot_Enemy_Pet_Text;
	MTLove_GUI_BT_Mo_Enemy_Npc_Text						= MTLove_GUI_BT_Mot_Enemy_Npc_Text;
	MTLove_GUI_BT_Mo_Neutral_Npc_Text					= MTLove_GUI_BT_Mot_Neutral_Npc_Text;
end
