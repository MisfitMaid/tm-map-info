namespace TMX {
    dictionary@ mapTags = dictionary();
    const string getMapByUidEndpoint = "https://trackmania.exchange/api/maps/get_map_info/uid/{id}";
    const string getTagsEndpoint = "https://trackmania.exchange/api/tags/gettags";

    // <https://api2.mania.exchange/Method/Index/37>
    Json::Value@ GetMapFromUid(const string &in uid) {
        string url = getMapByUidEndpoint.Replace("{id}", uid);
        auto req = PluginGetRequest(url);
        req.Start();
        while (!req.Finished()) yield();
        if (req.ResponseCode() >= 400 || req.ResponseCode() < 200 || req.Error().Length > 0) {
            log_warn("[status:" + req.ResponseCode() + "] Error getting map by UID from TMX: " + req.Error());
            return null;
        }
        // log_info("Debug tmx get map by uid: " + req.String());
        return Json::Parse(req.String());
    }

    void OpenTmxTrack(int TrackID) {
#if DEPENDENCY_MANIAEXCHANGE
        try {
            if (S_OpenTmxInManiaExchange && Meta::GetPluginFromID("ManiaExchange").Enabled) {
                ManiaExchange::ShowMapInfo(TrackID);
                return;
            }
        } catch {}
#endif
        OpenBrowserURL("https://trackmania.exchange/s/tr/" + TrackID);
    }

    void OpenTmxAuthor(int TMXAuthorID) {
#if DEPENDENCY_MANIAEXCHANGE
        try {
            if (S_OpenTmxInManiaExchange && Meta::GetPluginFromID("ManiaExchange").Enabled) {
                ManiaExchange::ShowUserInfo(TMXAuthorID);
                return;
            }
        } catch {}
#endif
        OpenBrowserURL("https://trackmania.exchange/user/profile/" + TMXAuthorID);
    }

    void LoadMapTags() {
        auto req = PluginGetRequest(getTagsEndpoint);
        req.Start();
        while (!req.Finished()) yield();
        if (req.ResponseCode() >= 400 || req.ResponseCode() < 200 || req.Error().Length > 0) {
            log_warn("[status:" + req.ResponseCode() + "] Error getting Map Tags from TMX: " + req.Error());
            return;
        }

        Json::Value@ jsonMapTags = Json::Parse(req.String());

        for(uint i = 0; i < jsonMapTags.Length; i++) {
            string id = tostring(int(jsonMapTags[i]['ID']));
            string name = jsonMapTags[i]['Name'];
            mapTags.Set(id, name);
        }
    }
}
