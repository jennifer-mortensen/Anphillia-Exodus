#include "hc_inc"
#include "anph_inc"

void PlaceObjects(string sObjectTag, string sLocationTag)
{
   int nSign = 0;
   object oSign = GetObjectByTag(sLocationTag, nSign);
   while (oSign != OBJECT_INVALID)
   {
      CreateObject(OBJECT_TYPE_PLACEABLE, sObjectTag, GetLocation(oSign));
      nSign++;
      oSign = GetObjectByTag(sLocationTag, nSign);
   }
}

void CreateJoinPortal(int nFaction)
{
   string sPortal = GetLocalString(GetModule(), "FACTION_0" + IntToString(nFaction) + "_JOINPORTAL");
   if (GetLocalInt(GetModule(), "FACTION_0" + IntToString(nFaction) + "_ACCESSIBLE_FOR_PLAYERS") == TRUE)
   {
      CreateObject(OBJECT_TYPE_PLACEABLE, sPortal, GetLocation(GetObjectByTag("join_faction_0" + IntToString(nFaction))));
   }
   else
   {
      CreateObject(OBJECT_TYPE_PLACEABLE, sPortal, GetLocation(GetObjectByTag("join_inact_faction_0" + IntToString(nFaction))));
   }
}

void main()
{
    /* Generate all Dream Items and placeables */
    PlaceObjects("dreamrpsign", "dreamroleplaysign");
    PlaceObjects("dreamupdate", "dreamupdatesign");

    /* Initalize Factions */
    SaveFactionsToModule();

    /* Generate all JoinFaction Portals */
    int nCurrentFaction;
    for (nCurrentFaction = 1; nCurrentFaction < (ANPH_NUMBER_OF_FACTIONS + 1); nCurrentFaction++)
    {
       CreateJoinPortal(nCurrentFaction);
    }

    // Execute CnR's OnModuleLoad Event if CnR is set active
    if (GetLocalInt(oMod, "ANPH_CNR_ACTIVE") == TRUE) ExecuteScript ("cnr_module_oml", OBJECT_SELF);

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Added by MikkoR to spawn CNR resources to waypoints
    // 9th June 2002: Code moved to cnr_resource_inc

    if (GetLocalInt(oMod, "ANPH_CNR_ACTIVE") == TRUE) ExecuteScript("cnr_resource_inc", GetModule());


    // End of resourcespawn code
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
