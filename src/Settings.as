[Setting hidden]
bool S_ShowMapInfo = true;

[Setting category="General" name="Show map info on loading screen"]
bool S_ShowLoadingScreenInfo = true;

[Setting category="General" name="Loading Screen Y Offset (%)" min=0 max=90]
float S_LoadingScreenYOffsetPct = 12.0;

[Setting category="General" name="Show author flags"]
bool S_Nationalism = true;

[Setting category="General" name="Show Debug Window (must be in a map)"]
bool S_ShowDebugUI = false;

[Setting category="General" name="Add Debug Window toggle to Plugins Menu"]
bool S_ShowDebugMenuItem = false;



[Setting category="General" name="Log Level"]
LogLevel S_LogLevel = LogLevel::Info;

#if DEPENDENCY_MANIAEXCHANGE
[Setting category="Integrations" name="Open TMX Links in the ManiaExchange plugin?"]
bool S_OpenTmxInManiaExchange = true;
#else
bool S_OpenTmxInManiaExchange = false;
#endif
