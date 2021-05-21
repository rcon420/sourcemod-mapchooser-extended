public Plugin myinfo = {
    name = "Dynamic Mapcycle",
    author = "lugui - code & rcon420 - idea",
    description = "Changes the mapcycle on the fly based on game state.",
    version = "1.0.0",
    url = "https://github.com/rcon420/sourcemod-mapchooser-extended",
};

ConVar cvarCfgFile;
KeyValues Kv_mapConfigs;

public OnPluginStart() {
    cvarCfgFile = CreateConVar("dmc_cfg_file", "configs/mapchooser_extended/dynamic_mapcycle.cfg", "Config file that will be used");

    char time[64]
    FormatTime(time, sizeof time, "Current time %H:%M at timezone: %z");
    PrintToServer("%s", time);

    Handle recheckCfg = CreateTimer(3.0, Timer_Global, _, TIMER_REPEAT);
    TriggerTimer(recheckCfg);
}

public Action Timer_Global(Handle timer){
    char buffer[128];
    GetConVarString(cvarCfgFile, buffer, sizeof(buffer));
    char cgfPAth[PLATFORM_MAX_PATH];
    BuildPath(Path_SM, cgfPAth, PLATFORM_MAX_PATH, buffer);

    Kv_mapConfigs = new KeyValues("mapConfigs");
    Kv_mapConfigs.ImportFromFile(cgfPAth);
    Kv_mapConfigs.Rewind();
    Kv_mapConfigs.GotoFirstSubKey();

    int playerCount = GetPlayerCount();

    // Parse current time
    char currentTime[32];
    FormatTime(currentTime, sizeof(currentTime), "%H:%M");
    char splitCurrentTime[2][16];
    ExplodeString(currentTime, ":", splitCurrentTime, 2, 16, false);
    int iCurrentTime = StringToInt(splitCurrentTime[0], 10) * 60 + StringToInt(splitCurrentTime[1], 10);

    char weekDayStr[4];
    FormatTime(weekDayStr, sizeof(weekDayStr), "%u");
    int currentWeekDay = StringToInt(weekDayStr, 10);

    do {
        char minPlayers[16];
        char maxPlayers[16];
        char timeStart[16];
        char timeEnd[16];
        char minWeekDay[16];
        char maxWeekDay[16];

        char kName[255];
        Kv_mapConfigs.GetSectionName(kName, sizeof(kName));

        Kv_mapConfigs.GetString("minPlayers", minPlayers, sizeof minPlayers, "null");
        Kv_mapConfigs.GetString("maxPlayers", maxPlayers, sizeof maxPlayers, "null");
        Kv_mapConfigs.GetString("timeStart", timeStart, sizeof timeStart, "null");
        Kv_mapConfigs.GetString("timeEnd", timeEnd, sizeof timeEnd, "null");
        Kv_mapConfigs.GetString("minWeekDay", minWeekDay, sizeof minWeekDay, "null");
        Kv_mapConfigs.GetString("maxWeekDay", maxWeekDay, sizeof maxWeekDay, "null");

        if(!StrEqual(minPlayers, "null")){
            int iMinPlayers = StringToInt(minPlayers, 10);
            if(playerCount < iMinPlayers){
                continue;
            }
        }

        if(!StrEqual(maxPlayers, "null") ){
            int iMaxPlayers = StringToInt(maxPlayers, 10);
            if(!StrEqual(minPlayers, "null") && StringToInt(minPlayers, 10) < iMaxPlayers) {
                LogError("Error at key %s. maxPlayers cannot be smaller than minPlayers", kName);
                continue;
            }

            if(playerCount > iMaxPlayers) {
                continue;
            }
        }

        if(!StrEqual(timeStart, "null")){
            char splitStartTime[2][16];
            ExplodeString(timeStart, ":", splitStartTime, 2, 16, false);
            int iStartTime = StringToInt(splitStartTime[0], 10) * 60 + StringToInt(splitStartTime[1], 10);

            if(!StrEqual(timeEnd, "null")){
            char splitEndTime[2][16];
            ExplodeString(timeEnd, ":", splitEndTime, 2, 16, false);
            int iEndTime = StringToInt(splitEndTime[0], 10) * 60 + StringToInt(splitEndTime[1], 10);

            if(iStartTime > iEndTime) {
                LogError("Error at key %s. timeStart cannot be greater than timeEnd", kName);
                continue;
            }
        }

            if(iCurrentTime < iStartTime){
                continue;
            }
        }

        if(!StrEqual(timeEnd, "null")){
            char splitEndTime[2][16];
            ExplodeString(timeEnd, ":", splitEndTime, 2, 16, false);
            int iEndTime = StringToInt(splitEndTime[0], 10) * 60 + StringToInt(splitEndTime[1], 10);

            if(!StrEqual(timeStart, "null")){
            char splitStartTime[2][16];
            ExplodeString(timeStart, ":", splitStartTime, 2, 16, false);
            int iStartTime = StringToInt(splitStartTime[0], 10) * 60 + StringToInt(splitStartTime[1], 10);

            if(iStartTime > iEndTime) {
                LogError("Error at key %s. timeStart cannot be greater than timeEnd", kName);
                continue;
            }
        }

            if(iCurrentTime > iEndTime){
                continue;
            }
        }

        if(!StrEqual(minWeekDay, "null")){
            int iMinWeekDay = StringToInt(minWeekDay, 10);
            if(currentWeekDay < iMinWeekDay){
                continue;
            }
        }

        if(!StrEqual(maxWeekDay, "null")){
            int iMaxWeekDay = StringToInt(maxWeekDay, 10);
            if(currentWeekDay > iMaxWeekDay){
                continue;
            }
        }

        // It does. Parse maps
        char mapListPath[256];
        BuildPath(Path_SM, mapListPath, PLATFORM_MAX_PATH, "data/tmp_maplist.txt");

        if(FileExists(mapListPath)){
            DeleteFile(mapListPath);
        }

        File tmpMaplist = OpenFile(mapListPath,"a+");

        Kv_mapConfigs.GotoFirstSubKey();
        Kv_mapConfigs.GotoFirstSubKey();
        do {
            char subKName[32];
            for (int i = 0; i < 999; i++) {
                char mapName[128];
                Format(subKName, sizeof(subKName), "%d", i);
                Kv_mapConfigs.GetString(subKName, mapName, sizeof(mapName), "null");
                if(!StrEqual(mapName, "null")) {
                    // PrintToServer("%s", mapName);
                    tmpMaplist.WriteLine("%s", mapName);
                }
            }
        } while (Kv_mapConfigs.GotoNextKey());
        tmpMaplist.Close();
        Kv_mapConfigs.GoBack();
        Kv_mapConfigs.GoBack();
        return;
    } while (Kv_mapConfigs.GotoNextKey());

    LogError("No adequate mapcycle found for current server conditions.");
    return;
}

stock int GetPlayerCount() {
    int playerCount = 0;
    for (int i = 1; i <= MaxClients; i++) {
        if (!isValidClient(i, false)) continue;
        playerCount++;
    }

    return playerCount;
}

stock bool isValidClient(int client, bool allowBot = false) {
	if ( !( 1 <= client <= MaxClients ) || !IsClientInGame(client) || IsClientSourceTV(client) || (!allowBot && IsFakeClient(client) ) ){
		return false;
	}
	return true;
}