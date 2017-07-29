/*******************************************************************************
* FILENAME :        main.pwn
*
* DESCRIPTION :
*       Linkage of all modules and includes, definiton of values.
*
* NOTES :
*       This file is not intended to handle player's functions or anything.
*       This file must only have links and constants.
*
*       Copyright Paradise Happy Devs 2017.  All rights reserved.
*/

// Required to be at the top
#include <a_samp>

//------------------------------------------------------------------------------

// Script versioning
#define SCRIPT_VERSION_MAJOR							"0"
#define SCRIPT_VERSION_MINOR							"3"
#define SCRIPT_VERSION_PATCH							".1"
#define SCRIPT_VERSION_NAME							"PC:RPG"

// Database
#define MySQL_HOST		"localhost"
#define MySQL_USER		"root"
#define MySQL_DB		"gtamissions"
#define MySQL_PASS		""
new gMySQL;

//------------------------------------------------------------------------------


// Libraries
#include <crashdetect>
#include <a_mysql>
#include <YSI\y_hooks>
#include <YSI\y_timers>
#include <YSI\y_iterate>
#include <streamer>
#include <YSI\y_commands>
#include <YSI\y_va>
#include <progress2>
#include <fnumb>
#include <util>
#include <vcolor>
#include <zones>
#include <mSelection>
#include <radars>
#include <vending>
#include <cuffs>
#include <sscanf2>
#include <sscanffix>
#include <log>

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	print("\n\n============================================================\n");
	print("Initializing...\n");
    SetGameModeText(SCRIPT_VERSION_NAME " " #SCRIPT_VERSION_MAJOR "." #SCRIPT_VERSION_MINOR "." #SCRIPT_VERSION_PATCH);

    // MySQL connection
    mysql_log(LOG_ERROR | LOG_WARNING | LOG_DEBUG);
	gMySQL = mysql_connect(MySQL_HOST, MySQL_USER, MySQL_DB, MySQL_PASS);
	if(mysql_errno(gMySQL) != 0)
    {
        print("ERROR: Could not connect to database!");
        return -1; // Stop the initialization if can't connect to database.
    }
	else
        printf("[mysql] connected to database %s at %s successfully!", MySQL_DB, MySQL_HOST);

	// Gamemode settings
	ShowNameTags(1);
	UsePlayerPedAnims();
	DisableInteriorEnterExits(); // For server-sided entrances
	SetNameTagDrawDistance(40.0);
	EnableStuntBonusForAll(false);
	return 1;
}

//------------------------------------------------------------------------------

// Modules

/* Defs */
#include "../modules/def/checkpoint.pwn"
#include "../modules/def/achievement.pwn"
#include "../modules/def/ranks.pwn"
#include "../modules/def/buttons.pwn"
#include "../modules/def/job.pwn"
#include "../modules/def/dialogs.pwn"
#include "../modules/def/ftime.pwn"
#include "../modules/def/messages.pwn"
#include "../modules/def/missions.pwn"
#include "../modules/def/statscol.pwn"
#include "../modules/def/licenses.pwn"
#include "../modules/def/gang.pwn"

/* Server - Required to be at the top*/
#include "../modules/anticheater/anticheater.pwn"

/* Data */

#include "../modules/data/building.pwn"
#include "../modules/data/vehicle.pwn"
#include "../modules/data/faction.pwn"
#include "../modules/data/player.pwn"
#include "../modules/data/gang.pwn"

/* Properties */
#include "../modules/properties/vehicle.pwn"
#include "../modules/properties/apartment.pwn"
#include "../modules/properties/house.pwn"
#include "../modules/properties/business.pwn"

/* Vehicle */
#include "../modules/vehicle/control.pwn"
#include "../modules/vehicle/reserve.pwn"
#include "../modules/vehicle/dschool.pwn"
#include "../modules/vehicle/status.pwn"
#include "../modules/vehicle/fueling.pwn"

/* Game */
#include "../modules/game/mapicons.pwn"
#include "../modules/game/automsg.pwn"
#include "../modules/game/pause.pwn"
#include "../modules/game/clock.pwn"
#include "../modules/game/preloadanim.pwn"
#include "../modules/game/vending.pwn"

/* Gameplay */
#include "../modules/gameplay/8track.pwn"
#include "../modules/gameplay/motocross.pwn"
#include "../modules/gameplay/handshake.pwn"
#include "../modules/gameplay/blowjob.pwn"
#include "../modules/gameplay/kiss.pwn"
#include "../modules/gameplay/hospital.pwn"
#include "../modules/gameplay/lottery.pwn"
#include "../modules/gameplay/tutorial.pwn"
#include "../modules/gameplay/paintball.pwn"
#include "../modules/gameplay/weather.pwn"
#include "../modules/gameplay/phone.pwn"
#include "../modules/gameplay/shtrange.pwn"
#include "../modules/gameplay/gps.pwn"
#include "../modules/gameplay/radars.pwn"
#include "../modules/gameplay/fighting.pwn"
#include "../modules/gameplay/bank.pwn"
#include "../modules/gameplay/boxing.pwn"
#include "../modules/gameplay/gym.pwn"
#include "../modules/gameplay/prision.pwn"
#include "../modules/gameplay/rentbike.pwn"
#include "../modules/gameplay/anims.pwn"
#include "../modules/gameplay/pursuit.pwn"

/* Player */
#include "../modules/player/achievement.pwn"
#include "../modules/player/chat.pwn"
#include "../modules/player/commands.pwn"
#include "../modules/player/deadbody.pwn"
#include "../modules/player/needs.pwn"
#include "../modules/player/pets.pwn"

/* Admin */
#include "../modules/admin/funcs.pwn"
#include "../modules/admin/commands.pwn"

/* Factions */
#include "../modules/faction/general.pwn"
#include "../modules/faction/cnn.pwn"
#include "../modules/faction/lspd.pwn"

/* Visual */
#include "../modules/visual/fade.pwn"
#include "../modules/visual/speedo.pwn"
#include "../modules/visual/subtitles.pwn"
#include "../modules/visual/needs.pwn"
#include "../modules/visual/stats.pwn"
#include "../modules/visual/gps.pwn"
#include "../modules/visual/logo.pwn"
#include "../modules/visual/login.pwn"
#include "../modules/visual/businfo.pwn"
#include "../modules/visual/boxing.pwn"
#include "../modules/visual/licenses.pwn"
#include "../modules/visual/xpbar.pwn"
#include "../modules/visual/gang.pwn"
#include "../modules/visual/pursuit.pwn"

/* NPCs */
#include "../modules/npcs/actors.pwn"
#include "../modules/npcs/npcs.pwn"

/* Cutscenes */
#include "../modules/cutscenes/cityhall.pwn"

/* Jobs */
#include "../modules/job/pilot.pwn"
#include "../modules/job/trucker.pwn"
#include "../modules/job/lumberjack.pwn"
#include "../modules/job/navigator.pwn"
#include "../modules/job/paramedic.pwn"
#include "../modules/job/garbage.pwn"
#include "../modules/job/hotdog.pwn"
#include "../modules/job/icecream.pwn"
#include "../modules/job/fisher.pwn"
#include "../modules/job/taxi.pwn"
#include "../modules/job/technical.pwn"
#include "../modules/job/pizzaboy.pwn"
#include "../modules/job/busdriver.pwn"
#include "../modules/job/commands.pwn"

/* Gangs */
#include "../modules/gangs/gangs.pwn"
#include "../modules/gangs/commands.pwn"


/* Missions */
#include "../modules/missions/gta.pwn"
#include "../modules/missions/colonel.pwn"

/* Objects */
#include "../modules/objects/hospital.pwn"
#include "../modules/objects/airport.pwn"
#include "../modules/objects/player.pwn" // a.k.a attachments
#include "../modules/objects/lspd.pwn"
#include "../modules/objects/bank.pwn"
#include "../modules/objects/petshop.pwn"

/* Core */
#include "../modules/core/timers.pwn"

/* Server */
#include "../modules/server/rcon.pwn"
//#include <nex-ac>

//------------------------------------------------------------------------------

main()
{
	printf("\n\n%s %s.%s%s initialiazed.\n", SCRIPT_VERSION_NAME, SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH);
	printf("============================================================\n");
}
