MTLove v2.4.4a by Herrmann, Tom
from Randoom.org eddited by malfdawg and dartraiden.

This addon adds a "target of mouseover" function to the wow-client
(the "mouseover" is the unit who is under your mouse-cursor).
The main advantage compared to Blizzard's built-in function is that you don't need to switch your
target to get this information which is much faster, especially in combat and you can still cast
spells on your target.
It was originally made to help tanks (therefore the name MTLove -> Main-Tanks-Love) but it may is
also useful for any other class.

It provides a frame attached to your mouse and/or a additional tooltip next
to the default one.
In addition it can add small counters to its frame, its tooltip, the default target-frame
and the default focus-frame, which display the number of players per class or armor type
who have your mouseover/target/focus as target.

Note on Tanks:
  party/raid member are assumed tanks if they qualify as:
    - set as tank via oRA3 Addon
    - set as "maintank" via Blizzard's Raid-UI (only if oRA3 tanks are not available)
    - or if neither oRA3 tanks nor "maintank" is set
       - warriors
       - druids in bear-form
       - paladins using righteous fury
       - death knights using blood presence

Usage:
   All settings are set up using a setup-GUI. It can be opened with typing '/mtlove' into
   your chat and pressing the [ENTER]-key or via the addon-tab in the interface options.
   Settings are stored for each character separately.

How to enable, disable or override the localization:
   To enable or disable the localization rename the "MTLoveLocalization_on.lua"-File
   to "MTLoveLocalization_off.lua" or the other way around.
   To override the WOW-Client localization open the "MTLoveLocalization_on.lua"-File and
   change the word "default" to the wanted ID.
   Possible ID's are listed in the file.

Optional Supported Addons:
 * oRA3
 * CT_RaidAssist (not verified yet)
 * TipBuddy (last verified Version: 2.38, "tipbuddy for wow 2.0" from curse-gaming.com)
 * myAddons (last verified Version: 2.7)

Thanks goes to:
 - kain for now unused French translation for version 2.0.0

Recommendation(s):
 ! Please remove the whole MTLove folder before updating the addon.
   Don't just overwrite the old with the new one.

Bug(s)/Limitations:
 # nothing known

Changes (* notice | + feature added, replaced or improved | - feature removed | # bugfix):
---v2.4.3b--- 2011/05/03
 + updated TOC-file for client version 4.1.0
 
---v2.4.3a--- 2010/10/28
 + removed oRA3 experimental status

---v2.4.3--- 2010/10/28
 + updates for client version 4.0.1 (Cataclysm) from Dridzt
    + oRA support updated for oRA3
 
---v2.4.2--- 2010/10/03
 # tooltip shows class name localized again
 + updated TOC-file for client version 4.0.1
 
---v2.4.1--- 2010/03/09
 # focus counter offset corrected
 
---v2.4.0--- 2010/02/06
 # fixed settings conversion

---v2.4.0.BETA--- unreleased
 + classification (and coloration) by class (e.g. mage, hunter) (new default)
   classification by armor type still available as an option
 + tanks are now displayed in light gray not in white
 + unseparated units are displayed in dark gray
 + >healer< highlight now also highlights [tanks]
 + classes/types which are not present in your group/raid are hidden in counters
   (don't show 0 all the time)
 + changed "-" separation in counters to ":" to conserve a little space
 + new option to (don't) count yourself/your pet (default: don't count yourself)
 + some code cleanup and simplification
 
---v2.3.1a--- 2009/12/12
 + updated TOC-file for client version 3.3.0
 
---v2.3.1--- 2009/09/12
 + fixed loading defaults for players who can control pets and daemons
 + fixed font on disabled buttons
   
---v2.3.0b--- 2009/08/07
 + updated TOC-file for client version 3.2.0
   (untested as oRA2 and CT_RaidAssist support, because I stopped playing WoW a while ago)
   
---v2.3.0a--- 2009/04/18
 + updated TOC-file for client version 3.1.0
   (untested as oRA2 and CT_RaidAssist support, because I stopped playing WoW a while ago)
 
---v2.3.0--- 2009/03/01
 * oRA2 and CT_RaidAssist support still unverified
 + oRA2 and CT_RaidAssist support has to be activated on the about page in MTLove's configuration

---v2.3.0.RC2--- 2009/02/08
 + paladins and death knights using Righteous Fury or Frost Presence are now recognized as tanks
 
---v2.3.0.RC1--- 2009/02/01
 + added unverified support for oRA2's and CT_RaidAssist's MainTank lists

---v2.3.0.BETA--- unreleased
 + performance and memory usage improvements
 + some code cleanup
 + update frequency reduced to 0.1 seconds (was updated with every screen redraw before)
 + major XML- (interface description) cleanup
 + make use of Blizzards interface options addons panel
 + some setup interface cleanup
 - finally removed all non-GUI-commands (except /mtlove)

---v2.2.5--- 2008/12/11
 + added support for death knights
 
---v2.2.4--- 2008/10/27
 + added a counter for the focus(-frame)
 # fixed visibility issue with activated numerical threat interface option
 
---v2.2.3--- 2008/10/18
 + better defaults for hunters and warlocks
 + updated TOC-file for client version 3.0.2
 # fixed deactivation of advanced counter options if all counters are disabled
 # fixed cpu/mem profiling would reset stats even if deactivated

---v2.2.2--- 2008/04/08
 # fixed trying to get Party Assignment (If the unit is MainTank or not) for
   units who do not belong to your party. Caused WoW to print following
   system message: "mouseovertarget is not in your party"
 
---v2.2.1--- 2008/03/29
 + changed the copyright note to my real name
 + updated TOC-file for client version 2.4.0
 
---v2.2.0a--- 2007/11/16
 + updated TOC-file for client version 2.3.0

---v2.2.0--- 2007/08/17
 + updated TOC-file for client version 2.2.0
 # fixed tank abstraction using blizzards standard raid-interface option
 
---v2.2.0.RC2--- 2007/05/27
 + tank abstraction uses blizzards standard raid-interface option
   (if "maintank" is set, its the only tank-unit, if not any warrior and any druid in bear-form)
 + stats are not performed on any script cycle to save performance
 + max, average and min values for stats

---v2.2.0.RC1--- 2007/05/24
 + optimized defaults
 + added counter for the "normal" target
 + added new GUI-tab ("about...") for some notes
 + added some notes there (about counters and performance problems with them)
 + new GUI/UI Option to enable/disable the normal-target-counter
 + updated TOC-file for client version 2.1.0
 + added Memory stats to "about..." tab
 + added CPU stats to "about..." tab
 - removed/shrinked UI translations
 - removed "settings" non-GUI-command

---v2.2.0.BETA_3--- 2007/04/03
 + doesn't spam settings while loading defaults at start up or via Non-GUI-command
 + new unit abstraction for all messages: tanks (warriors and druids in bear-form)
 + tanks show up in white, as your character before (your character still does if its a tank)
 + units recognized as tanks are not highlighted via the healer-highlight-option
   (affects only druids at the moment)
 + new GUI/UI Option for enable/disable counting tanks
 # fixed loading defaults if no settings found

---v2.2.0.BETA_2--- 2007/03/28
 + improved version detection for
   garbage cleaning of SavedVariables
 + optimized GUI (button ordering, tabs)
 + now loads defaults if no settings found
 + internal changes to the counting algorithm (somewhat faster)
 + added UI/GUI commands for some counter options
 + separated non-GUI-command-listing readme
 + ability to wear certain armor is now also level based and takes the lvl 40 "change" into account

---v2.2.0.BETA_1--- 2007/02/12
 + new counters which displays the number of players per armor class who have your mouseover
   as target, frame and/or tooltip attached
 + added UI/GUI commands/buttons to enable/disable them
 + exchanged mot- with mo-hp-bar
 + message when cleaning the settings
 + added new mouseovertarget-types:
   mo_self -> if the mouseover targets itself (eg: for healing)
   nothing -> if the mouseover targets nothing (to show the new counter(s) even if
   not (yet) in combat - may useful for raid-coordination)
 + added UI/GUI commands/buttons to enable/disable them and the older stun display
 + added UI/GUI command/button for loading defaults for all settings

---v2.2.0.ALPHA_4--- unreleased
 * setup-GUI re-enabled
 + new/updated setup-GUI which reflects the command changes from v2.2.0.ALPHA_3
 + stop to print into the chat if configured with the setup-GUI
 + "updated" the German translation to the "new" German wow-terminology:
   Pet -> Begleiter, Level -> Stufe
 # fixes various spelling/naming/typo "bugs"

---v2.2.0.ALPHA_3--- unreleased
 * setup-GUI disabled
 + updated TOC-file for client version 2.0.3
 + updated localization
 + updated the readme files
 + new/updated Non-GUI-commands which reflect the Saved-Variables changes from v2.2.0.ALPHA_2
   also improved naming scheme used (may not easy to type)
 # fixed that pets and NPCs are highlighted by the healer-highlight option
   (the WOW-client claims that some pets, like the voidwalker, are a healing class)
 # fixed that partymembers (players/pets) are not believed to be players/pets while coloring
 # fixes various spelling/naming/typo "bugs"

---v2.2.0.ALPHA_2--- unreleased
 * setup-GUI disabled
 + now hides frame/tooltip, if the target from the mouseover is dead or doesn't exist at all
 + new Saved-Variables which reflect the routine changes from v2.2.0.ALPHA_1,
   also new naming scheme used and version information added
   (As its not possible to convert all old settings to a new equivalent,
    because the old are "not very" precise, they are only converted to there "nearest neighbor")
 + added garbage cleaning for SavedVariables
 # removed small bug in tooltip building routine

---v2.2.0.ALPHA_1--- unreleased
 * high amount of planned changes let me decide to name this new Alpha for next
   minor-version-step
 + changed Non-GUI-command "cmdhelp" to "help"
 + updated in game help-texts
 + improved mouseover- and mouseovertarget-checking routine
   (now separates every possible unit-type)

---v2.1.4.BETA_2--- unreleased
 + updated in game help-texts
 + new debug-output-method

---v2.1.4.BETA_1--- 2006/12/19
 + new "always on" option to show the frame/tooltip for any inspected unit
   the new Non-GUI-commands are "/mtlove [show/hide/toggle] always"
 + new option to show the frame/tooltip even out of combat
   the new Non-GUI-commands are "/mtlove [show/hide/toggle] outofcombat"
 + completely new mouseover- and mouseovertarget-checking routine (no noticeable changes for users)
 # Pets are now counted to your party/raid.

---v2.1.3--- 2006/12/06
 + updated TOC-file for client version 2.0.x

---v2.1.2--- 2006/12/03
 # fixed PVP option (broken by "auto-Battleground-raid" introduced in 1.12 which is something
   between no party at all and a raid)
 # fixed NPC support

---v2.1.1--- 2006/11/03
 + updated myAddons-Support for MyAddons-Version 2.6
 + added option for highlighting healers
 + separated pets from other NPC's
 + some code-optimizations

---v2.1.0--- 2006/08/28
 + updated TOC-file for client version 1.12.x
 + tweaked the tooltip height
 # fixed yourself shown as humanoid, not as "Level xx RACE CLASS (Player)"

---v2.1.RC2--- 2006/08/10
 + NPC-color is a little brighter now
 + tooltip and frame "artwork" is now the same and more like the default wow-tooltip
 + full UI-Scale support
 + GUI-checkboxes and -buttons play the default wow sounds
 + some more script optimizations
 + recovered tipbuddy support
 # fixed bug in PVP support that mob's couldn't separated from enemy pets

---v2.1.BETA_8--- 2006/07/22
 - dropped the tooltip-expansion feature from BETA_7, as it is not very nice to handle
   and buggy as hell
 + keeps all other improvements
 + some internal changes to avoid multiple calls to the same function
 + some more "lost in space" changes

---v2.1.BETA_7--- 2006/07/17
 + GUI-Frame is now movable and close if you press the "ESC"-key
 + The Tooltip function doesn't add a tooltip anymore, it expands the old one
 - Removed tipbuddy support, because with the new tooltip-extension is no need for
   special tipbuddy implementation. But tipbudy may screws up MTLoves layout.
   As I don't use it I'll never check it anymore.

---v2.1.BETA_6--- 2006/07/13
 * dropped RC status, because I implemented some new features and screwed a lot things
 + Battleground option is replaced with "all the time affecting" PVP option
   the new Non-GUI-commands are "/mtlove [show/hide/toggle] pvp"
 + added pvp related option to also show the frame/tooltip if friendly players who are not
   in your party are attacked
   the new Non-GUI-commands are "/mtlove [show/hide/toggle] aliens"
 + added localization override option to enable/disable localization
 + if you are not a tank class your name is also color-coded and not white
 + some readme and GUI improvements
 # fixed bug with myAddons-Addon
 # updated internals to reflect client version 1.11.2 API changes

---v2.1.RC1--- 2006/06/21
 + updated TOC-file for client version 1.11.x
 + removed "/mtlove help"-command and linked "/mtlove" to "/mtlove setup"

---v2.1.BETA_5.1--- 2006/06/06
 # fixed that the frame/tooltip would stay in the lower left corner of the screen, if you are
   not in combat and mouseover somebody (normally hidden behind your default button-bar)
   (combined with another "bug that caused the frame appearing only..."-fix improvement)
 # some "what the f**k, why i don't have removed/changed this"-fixes

---v2.1.BETA_5--- 2006/06/05
 + now licensed under the terms of the GNU General Public License Version 2
 + added support for hide or show the frame/tooltip when you are in a Battleground
   the new Non-GUI-commands are "/mtlove [show/hide/toggle] bg"
 + faster initialization of the frame/tooltip
   (~1 sek (BETA_4.1) -> ~0.5 sek (BETA_5) on my system)
 + setup-GUI improvement
 + "bug that caused the frame appearing only..."-fix improvement to save some performance
   in non-combat situations
 - disabled French in game translation and removed the french readme, because I don't find somebody
   to update it
 # fixed a bug that leads in to an error, if you start the 2.1.Beta's without saved settings
 # fixed a bug that always enabled the frame if you relog/make an GUI-reset,
   even if you disabled the frame

---v2.1.BETA_4.1--- 2006/05/14
 + added support for "TipBuddy"-Addon

---v2.1.BETA_4--- 2006/05/13
 + some readme and "/mtlove cmdhelp"-command improvements
 # fixed a bug that caused the frame and tooltip appearing only if you "re-mouseover" the mob
   while starting combat

---v2.1.BETA_3--- 2006/05/08
 + "feared/stunned"-color changed to gray
 + MOB's-Target-HP-Bar-color at frame and tooltip changed to yellow
 + some internal changes

---v2.1.BETA_2--- 2006/04/28
 + shows "feared/stunned" if the mob is in combat, but doesn't attack
 - removed special frame border, because it was nearly the default one
 - removed "/mtlove [on/hide/toggle]" option, because it is now replaced with the frame and
   tooltip options.

---v2.1.BETA_1.1--- 2006/04/24
 + added new Non-GUI-commands "/mtlove [show/hide/toggle] frame" to show/hide/toggle
   MTLove's main frame (now everywhere called "frame")
 + added new Non-GUI-command "/mtlove settings" for displaying MTLove's settings
   (also removed settings from startup-post)
 # fixed unexpected critical bug while loading variables
   (amazing that it worked before)
   (also deactivates all new functions from the update if you update MTLove)

---v2.1.BETA_1--- 2006/04/23
 + new tooltip, attached to the normal Mob-tooltip (now everywhere called "tooltip", or "TT")
   the new Non-GUI-commands are "/mtlove [show/hide/toggle] tt"
 + added HP-Bars of the MOB and MOB's Target to the frame
   the new Non-GUI-commands are "/mtlove [show/hide/toggle] mobar" and
   "/mtlove [show/hide/toggle] motbar"
 + new minimum size for the frame

---v2.0.0--- 2006/04/09
 # removed bug in NPC handling

---v2.0.Beta1/2/3/4/RC1---
 + rewritten nearly everything ( + all the code is a bit cleaner now [at least for me]
                                 + smaller start up post
                                 + uses the new "SavedVariablesPerCharacter" method
                                 + better NPC support
                                 + perhaps small speedup)
 + added support to hide or show the frame when you are not in party
   the new Non-GUI-commands are "/mtlove show party" and "/mtlove hide party"
 + added support for "myAddOns"-Addon
 + added new and simple setup-GUI
   the new Non-GUI-command to open it is "/mtlove setup"
 + added offset restriction to -201 < x/y < 201, because I think offset >200 is not needed
   and it improves GUI compatibility
 + added new Non-GUI-command "/mtlove resetxy" to reset the offset
 + added German and French localization (French translation by kain)
 + added file to enable/disable localization
 + used more structured folder-layout
 + reworked non-GUI-commands to be more logical
 + updated TOC-file for client version 1.10.x
 - removed special frame background, because it was nearly the default one
 # fixed "myAddons" GUI loading bug (from 2.0.Beta_1,2 and 3) also removed refresh button
 # some more non-critical bug fixes

---v1.2.ml--- 2006/02/05
 + added support for NPC's (pets, quest npc's)
   The new commands are "/mtlove shownpc" ans "/mtlove hidenpc".
   They are is colored in purple.

---v1.1.ml--- 2006/01/27
 + updated the "original" code to work on all language versions of wow
   all configuration information is still presented in English,
   but the "coloration" now works on all languages
   (not only EN, DE, FR, KR, really all).
 + updated the TOC-file for client version 1.9.X