#include "ats_const_common"
#include "ats_inc_common"
#include "moth_inc"
#include "_inc_xp"
#include "_inc_faction"

//// General include file for Anphillia

// These are test-includes to see if the script compiles at all
//#include "hc_inc"
//#include "anph_config_inc"

/* FACTION SETTINGS
These set up all Factions in the game, you can freely add up to this list
as long as you provide the item blueprints, start locations etc...
Maximum Faction Count = 9 */
int ANPH_NUMBER_OF_FACTIONS = 2;
object oModule = GetModule();

/* This function saves all faction-relevant data to Local Variables */

void SaveFactionsToModule()
{

// We need some Variables even if no faction is set
   SetLocalString(oModule, "FACTION_00_FUGUE", "DreamStartLocation");
   SetLocalString(oModule, "FACTION_00_DREAMSTART", "ChooseSideLocation");
   SetLocalInt(oModule, "Relic_Status", 0);

// CLEAVEN FACTION
   SetLocalString(oModule, "FACTION_01_NAME", "Cleaven");
   //SetLocalString(oModuleule, "FACTION_01_JOIN_SCRIPT", "anph_join_cleave");
   SetLocalString(oModule, "FACTION_01_RING", "cleavenmilitiari");
   //SetLocalString(oModule, "FACTION_01_HORN", "MothBattleHorn");
   SetLocalString(oModule, "FACTION_01_KEY", "cleavengatekey");
   SetLocalString(oModule, "FACTION_01_SPECIAL_OBJECT", "");
   SetLocalString(oModule, "FACTION_01_STARTLOCATION", "CleavenStartLocation");
   SetLocalString(oModule, "FACTION_01_FUGUE", "CleavenFugue");
   SetLocalString(oModule, "FACTION_01_FACTIONOBJECT", "CleavenFaction");
   SetLocalString(oModule, "FACTION_01_DREAMSTART", "CleavenDreamStartLocation");
   SetLocalString(oModule, "FACTION_01_JOINPORTAL", "joincleaven");


// AXFELL FACTION
   SetLocalString(oModule, "FACTION_02_NAME", "Axfell");
   //SetLocalString(oModule, "FACTION_02_JOIN_SCRIPT", "anph_join_axfell");
   SetLocalString(oModule, "FACTION_02_RING", "axfellwarriorrin");
   //SetLocalString(oModule, "FACTION_02_HORN", "MothBattleHorn");
   SetLocalString(oModule, "FACTION_02_KEY", "axfellgatekey");
   SetLocalString(oModule, "FACTION_02_SPECIAL_OBJECT", "");
   SetLocalString(oModule, "FACTION_02_STARTLOCATION", "AxfellStartLocation");
   SetLocalString(oModule, "FACTION_02_FUGUE", "AxfellFugue");
   SetLocalString(oModule, "FACTION_02_FACTIONOBJECT", "AxfellFaction");
   SetLocalString(oModule, "FACTION_02_DREAMSTART", "");
   SetLocalString(oModule, "FACTION_02_JOINPORTAL", "joinaxfell");

// RANZINGTON FACTION
   SetLocalString(oModule, "FACTION_03_NAME", "Ranzington");
   //SetLocalString(oModule, "FACTION_03_JOIN_SCRIPT", "anph_join_ranz");
   SetLocalString(oModule, "FACTION_03_RING", "ranzingtoncitize");
   SetLocalString(oModule, "FACTION_03_HORN", "ranzingtonhorn");
   SetLocalString(oModule, "FACTION_03_KEY", "ranzingtongateke");
   SetLocalString(oModule, "FACTION_03_SPECIAL_OBJECT", "");
   SetLocalString(oModule, "FACTION_03_STARTLOCATION", "RanzingtonStartLocation");
   SetLocalString(oModule, "FACTION_03_FUGUE", "RanzingtonFugue");
   SetLocalString(oModule, "FACTION_03_FACTIONOBJECT", "RanzingtonFaction");
   SetLocalString(oModule, "FACTION_03_DREAMSTART", "RanzingtonDreamStartLocation");
   SetLocalString(oModule, "FACTION_03_JOINPORTAL", "joinranzington");

// DROW FACTION
   SetLocalString(oModule, "FACTION_04_NAME", "Drow");
   //SetLocalString(oModule, "FACTION_04_JOIN_SCRIPT", "anph_join_drow");
   SetLocalString(oModule, "FACTION_04_RING", "drowring");
   SetLocalString(oModule, "FACTION_04_HORN", "drowhorn");
   SetLocalString(oModule, "FACTION_04_KEY", "drowgatekey");
   SetLocalString(oModule, "FACTION_04_SPECIAL_OBJECT", "faeriefire");

   /* DrowStartLocation is handled specially for this faction because of
   special class-dependant StartLocation */
   SetLocalString(oModule, "FACTION_04_STARTLOCATION", "");


   SetLocalString(oModule, "FACTION_04_FUGUE", "DrowHell");
   SetLocalString(oModule, "FACTION_04_FACTIONOBJECT", "DrowFaction");
   SetLocalString(oModule, "FACTION_04_DREAMSTART", "DrowDreamStartLocation");
   SetLocalString(oModule, "FACTION_04_JOINPORTAL", "joindrow");

// SHILAR FACTION
   SetLocalString(oModule, "FACTION_05_NAME", "Shilar");
   //SetLocalString(oModule, "FACTION_03_JOIN_SCRIPT", "anph_join_shilar");
   SetLocalString(oModule, "FACTION_05_RING", "shilarring");
   SetLocalString(oModule, "FACTION_05_HORN", "shilarhorn");
   SetLocalString(oModule, "FACTION_05_KEY", "shilarkey");
   SetLocalString(oModule, "FACTION_05_SPECIAL_OBJECT", "");
   SetLocalString(oModule, "FACTION_05_STARTLOCATION", "ShilarStartLocation");
   SetLocalString(oModule, "FACTION_05_FUGUE", "ShilarFugue");
   SetLocalString(oModule, "FACTION_05_FACTIONOBJECT", "ShilarFaction");
   SetLocalString(oModule, "FACTION_05_DREAMSTART", "ShilarDreamStartLocation");
   SetLocalString(oModule, "FACTION_05_JOINPORTAL", "joinshilar");
}

object AnphFindPlayerByKey (string sName, string sCDK)
{
    string sID = sCDK + sName;
    string sThisName;
    string sThisCDK;
    string sThisID;

    object oPC = GetFirstPC();
    while (GetIsObjectValid (oPC) == TRUE)
    {
        sThisName = GetName (oPC);
        sThisCDK = GetPCPublicCDKey (oPC);
        sThisID = sThisCDK + sThisName;

        if (sThisID == sID)
        {
            return (oPC);
        }
        oPC = GetNextPC ();
    }
    return (OBJECT_INVALID);
}
string AnphFastGetPlayerTeam(object oPC)
{
   int iTeam = GetLocalInt(oPC, "AnphPlayerTeam");
   switch (iTeam)
   {
      case 1: return (GetLocalString(oModule, "FACTION_01_NAME"));
      case 2: return (GetLocalString(oModule, "FACTION_02_NAME"));
      case 3: return (GetLocalString(oModule, "FACTION_03_NAME"));
      case 4: return (GetLocalString(oModule, "FACTION_04_NAME"));
      case 5: return (GetLocalString(oModule, "FACTION_05_NAME"));
      case 6: return (GetLocalString(oModule, "FACTION_06_NAME"));
      case 7: return (GetLocalString(oModule, "FACTION_07_NAME"));
      case 8: return (GetLocalString(oModule, "FACTION_08_NAME"));
      case 9: return (GetLocalString(oModule, "FACTION_09_NAME"));

   }
   return ("Error");
}

int AnphFastGetPlayerTeamInt(object oPC)
{
   int iTeam = GetLocalInt(oPC, "AnphPlayerTeam");
   return iTeam;
}

int AnphGetPlayerTeamInt (object oPC)
{
    int iFastTeam = AnphFastGetPlayerTeamInt(oPC);
    if (iFastTeam != 0)
       return iFastTeam;

    if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_01_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 1);
        return (1);
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_02_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 2);
        return (2);
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_03_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 3);
        return (3);
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_04_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 4);
        return (4);
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_05_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 5);
        return 5;
    }
    /* deactivated, activate as needed
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oMod, "FACTION_06_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 6);
        return 6;
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oMod, "FACTION_07_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 7);
        return 7;
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oMod, "FACTION_08_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 8);
        return 8;
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oMod, "FACTION_09_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 9);
        return 9;
    }
    */

    return (0);

}

string AnphGetPlayerTeam (object oPC)
{
    string sFastTeam = AnphFastGetPlayerTeam(oPC);
    if (sFastTeam != "Error")
       return sFastTeam;

    if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_01_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 1);
        return (GetLocalString(oModule, "FACTION_01_NAME"));
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_02_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 2);
        return (GetLocalString(oModule, "FACTION_02_NAME"));
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_03_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 3);
        return (GetLocalString(oModule, "FACTION_03_NAME"));
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_04_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 4);
        return (GetLocalString(oModule, "FACTION_04_NAME"));
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_05_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 5);
        return (GetLocalString(oModule, "FACTION_05_NAME"));
    }
    /* deactivated, activate as needed
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_06_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 6);
        return (GetLocalString(oModule, "FACTION_06_NAME"));
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_07_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 7);
        return (GetLocalString(oModule, "FACTION_07_NAME"));
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_08_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 8);
        return (GetLocalString(oModule, "FACTION_08_NAME"));
    }
    else if (GetIsObjectValid (GetItemPossessedBy (oPC, GetLocalString(oModule, "FACTION_09_RING"))))
    {
        SetLocalInt(oPC, "AnphPlayerTeam", 9);
        return (GetLocalString(oModule, "FACTION_09_NAME"));
    }
    */

    return ("");

}

void AnphSendMessageToTeam (string sTeam, string sMessage)
{
    string sPCTeam;

    object oPC = GetFirstPC();
    while (GetIsObjectValid (oPC) == TRUE)
    {
        sPCTeam = AnphGetPlayerTeam (oPC);
        if (sPCTeam == sTeam)
        {
            SendMessageToPC (oPC, sMessage);
        }
        oPC = GetNextPC ();
    }
}
int AnphGetPlayerLevel (object oPC)
{
    int iLevel;

    iLevel = GetLevelByPosition (1, oPC);
    iLevel += GetLevelByPosition (2, oPC);
    iLevel += GetLevelByPosition (3, oPC);

    return (iLevel);
}

void AnphCheckPK (object oPlayer, object oKiller)
{
    if(!GetIsPC(oKiller))
        return;

    int nTeam = GetFaction(oPlayer);
    int nKTeam = GetFaction(oKiller);

    if (!nTeam || !nKTeam)
        return;

    object oPKArea = GetArea(oKiller);;

    if(oPKArea != GetArea(oPlayer))
        return;

    int iPlayerLvl;
    int iKillerLvl;
    int iXP;
    object oPC;
    int nPCFaction;
    string sTeam = GetFactionNameFromValue(nTeam);
    string sKTeam = GetFactionNameFromValue(nKTeam);

    if (nTeam != nKTeam)
    {
        //AnphSendMessageToTeam (sTeam, "<c  þ>[Faction] " + GetName (oPlayer) + " was killed by an " + sKTeam + " named " + GetName (oKiller) + ".</c>");
        //AnphSendMessageToTeam (sKTeam, "<c  þ>[Faction] " + GetName (oKiller) + " has slain an enemy " + sTeam + " named " + GetName (oPlayer) + ".</c>");

        //J. Persinne, Feb. 15 2010; we now send messages to all team members in the same area.
        string sKillerTeamMessage = "<c  þ>[Faction] " + GetName (oKiller) + " has slain an enemy " + sTeam + " named " + GetName (oPlayer) + ".</c>";
        string sVictimTeamMessage = "<c  þ>[Faction] " + GetName (oPlayer) + " was killed by an " + sKTeam + " named " + GetName (oKiller) + ".</c>";
        oPKArea = GetArea(oKiller);

        oPC = GetFirstPC();

        while(GetIsObjectValid(oPC))
        {
            nPCFaction = GetFaction(oPC);
            if(!nPCFaction)
                continue;
            if(GetArea(oPC) == oPKArea)
            {
                if(nPCFaction != nKTeam)
                {
                    SendMessageToPC(oPC, sVictimTeamMessage);
                }
                else
                {
                    SendMessageToPC(oPC, sKillerTeamMessage);
                }
            }
            oPC = GetNextPC();
        }

        iPlayerLvl = MothGetPlayerLevel (oPlayer);
        iKillerLvl = MothGetPlayerLevel (oKiller);
        iXP = iPlayerLvl * 50;
        if ((iKillerLvl - iPlayerLvl) > 3)
            iXP = 50;
        if (iXP > 450)
            iXP = 450;
        GiveVirtualXPToCreature (oKiller, iXP);
        SendMessageToAllDMs("" + GetName (oKiller) + " has killed " + GetName (oPlayer) + " in "+ GetName(GetArea(oPlayer)) +".");
    } else if (nTeam == nKTeam)
    {
        //AnphSendMessageToTeam (sTeam, "<c  þ>[Faction] " + GetName (oKiller) + " has killed a fellow " + sKTeam + " named " + GetName (oPlayer) + ".</c>");
        string sPKMessage = "<c  þ>[Faction] " + GetName (oKiller) + " has killed a fellow " + sKTeam + " named " + GetName (oPlayer) + ".</c>";
        oPKArea = GetArea(oKiller);
        oPC = GetFirstPC();
        while(GetIsObjectValid(oPC))
        {
            if(GetArea(oPC) == oPKArea)
                SendMessageToPC(oPC, sPKMessage);
            oPC = GetNextPC();
        }
    }
}

void AnphSendWarningCall (object oPC)
{
    string sPCTeam;
    string sTeam = AnphGetPlayerTeam (oPC);
    object oArea = GetArea (oPC);
    AnphSendMessageToTeam (sTeam, "<c  þ>[Faction] " + GetName (oPC) + " has sighted the enemy in the "
                           + GetName (oArea) + "!</c>");

    SendMessageToAllDMs("*** " + GetName (oPC) + " (" + sTeam + ") blew the horn in the " + GetName (oArea) + "! ***");

    object oPlayer;
    oPlayer = GetFirstPC ();
    object oPC = GetFirstPC();
    while (GetIsObjectValid (oPlayer) == TRUE)
    {
        sPCTeam = AnphGetPlayerTeam (oPlayer);
        if (sPCTeam == sTeam)
        {
            AssignCommand (oPlayer, PlaySound("as_an_wolfhowl1"));
        }
        oPlayer = GetNextPC ();
    }


}

void AnphCryDrow (object oPC)
{
    string sPCTeam;
    string sTeam = "Drow";
    object oArea = GetArea (oPC);
    AnphSendMessageToTeam (sTeam, "<c  þ>" + GetName (oPC) + " cries for drow ("
                           + GetPCPlayerName (oPC) + ")!</c>");

    SendMessageToAllDMs("*** " + GetName (oPC) + " needs dm (" + GetPCPlayerName (oPC) + ") ***");

    object oPlayer;
    oPlayer = GetFirstPC ();
    object oPC = GetFirstPC();
    while (GetIsObjectValid (oPlayer) == TRUE)
    {
        sPCTeam = AnphGetPlayerTeam (oPlayer);
        if (sPCTeam == sTeam)
        {
            AssignCommand (oPlayer, PlaySound("as_an_wolfhowl1"));
        }
        oPlayer = GetNextPC ();
    }


}

void UpdateTeamFaction (string sTeam, object oFactionMember, int iRating)
{
    object oPC;
    string sPlayerTeam;
    string sPCTeam;

    oPC = GetFirstPC();
    while (GetIsObjectValid (oPC) == TRUE)
    {
        sPCTeam = AnphGetPlayerTeam (oPC);

        if (sPCTeam == sTeam)
        {
            AdjustReputation (oPC, oFactionMember, iRating);
        }
        oPC = GetNextPC ();
    }
}

void AnphSurrender (object oFactionMember, object oPC)
{
    object oMember;
    string sTeam;

    sTeam = AnphGetPlayerTeam (oPC);

    oMember = GetFirstFactionMember (oFactionMember, FALSE);

    while (GetIsObjectValid (oMember))
    {
        UpdateTeamFaction (sTeam, oMember, 50);

        ExecuteScript ("anph_surrender", oMember);
        //SendMessageToPC (oPC, "Adjusting faction for " + GetTag (oMember));
        oMember = GetNextFactionMember (oFactionMember, FALSE);
    }
}

void CheckPlayerTeam (object oPlayer)
{
    object oPC;
    int nPlayerTeam;
    int nPCTeam;

    object oLamirFaction = GetObjectByTag ("LamirFaction");
    object oFaction01Member = GetObjectByTag (GetLocalString(oModule, "FACTION_01_FACTIONOBJECT")); // Cleaven
    object oFaction02Member = GetObjectByTag (GetLocalString(oModule, "FACTION_02_FACTIONOBJECT")); // Axfell
    object oFaction03Member = GetObjectByTag (GetLocalString(oModule, "FACTION_03_FACTIONOBJECT")); // Ranzington
    object oFaction04Member = GetObjectByTag (GetLocalString(oModule, "FACTION_04_FACTIONOBJECT")); // Drow
    object oFaction05Member = GetObjectByTag (GetLocalString(oModule, "FACTION_05_FACTIONOBJECT")); // -inactive-
    /* inactive factions, activate by demand
    object oFaction06Member = GetObjectByTag (GetLocalString(oModule, "FACTION_06_FACTIONOBJECT")); // -inactive-
    object oFaction07Member = GetObjectByTag (GetLocalString(oModule, "FACTION_07_FACTIONOBJECT")); // -inactive-
    object oFaction08Member = GetObjectByTag (GetLocalString(oModule, "FACTION_08_FACTIONOBJECT")); // -inactive-
    object oFaction09Member = GetObjectByTag (GetLocalString(oModule, "FACTION_09_FACTIONOBJECT")); // -inactive-
    */

    int nFaction;
    for (nFaction = 1; nFaction < (ANPH_NUMBER_OF_FACTIONS + 1); nFaction++)
    {
     // if (!GetIsObjectValid(GetObjectByTag(GetLocalString(oModule, "FACTION_0" + IntToString(nFaction) + "_FACTIONOBJECT"))));
    }

    nPCTeam = AnphGetPlayerTeamInt (oPlayer);
    if (nPCTeam == 2)
    {
        //SendMessageToPC (oPC, "Adjusting for Axfell");
        // DEBUG
        //SendMessageToAllDMs("Adjusting Faction for an Axfell");
        // END DEBUG
        AdjustReputation (oPlayer, oFaction01Member, -100);
        AdjustReputation (oPlayer, oFaction04Member, -100);
    }
    else if (nPCTeam == 1)
    {
        //SendMessageToPC (oPC, "Adjusting for Cleaven");
        // DEBUG
        //SendMessageToAllDMs("Adjusting Faction for a Cleaven");
        // END DEBUG
        AdjustReputation (oPlayer, oFaction02Member, -100);
        AdjustReputation (oPlayer, oFaction04Member, -100);
    }
    else if (nPCTeam == 3)
    {
        //SendMessageToPC (oPC, "Adjusting for Ranzington");
        // DEBUG
        //SendMessageToAllDMs("Adjusting Faction for a Ranzington");
        // END DEBUG
        AdjustReputation (oPlayer, oFaction04Member, -100);
    }
    else if (nPCTeam == 4)
    {
        //SendMessageToPC (oPC, "Adjusting for Drow");
        // DEBUG
        //SendMessageToAllDMs("Adjusting Faction for a Drow");
        // END DEBUG
        AdjustReputation (oPlayer, oFaction01Member, -100);
        AdjustReputation (oPlayer, oFaction02Member, -100);
        AdjustReputation (oPlayer, oFaction03Member, -100);
        AdjustReputation (oPlayer, oFaction05Member, -100);
    }
    else if (nPCTeam == 5)
    {
        //SendMessageToPC (oPC, "Adjusting for Shilar");
        // DEBUG
        //SendMessageToAllDMs("Adjusting Faction for a Shilar");
        // END DEBUG
        AdjustReputation (oPlayer, oFaction04Member, -100);
    }
    /* inactive faction reputations, activate and configure by demand
    else if (sPCTeam == GetLocalString(oModule, "FACTION_06_NAME"))
    {
    }
    else if (sPCTeam == GetLocalString(oModule, "FACTION_07_NAME"))
    {
    }
    else if (sPCTeam == GetLocalString(oModule, "FACTION_08_NAME"))
    {
    }
    else if (sPCTeam == GetLocalString(oModule, "FACTION_09_NAME"))
    {
    }
    */

    nPlayerTeam = AnphGetPlayerTeamInt (oPlayer);
    // SendMessageToPC (oPlayer, "Player team is '" + sPlayerTeam + "'");

    /* This sets the like/dislike of the factions */
    if (nPlayerTeam == 0)
       return;

    oPC = GetFirstPC();
    while (GetIsObjectValid (oPC) == TRUE)
    {
        if (oPC != oPlayer)
        {
            nPCTeam = AnphGetPlayerTeamInt (oPC);
            if (
                // Cleaven don't like Axfell and Drow
                (nPlayerTeam == 1 && (nPCTeam == 2 ||       // Axfell
                                      nPCTeam == 4)) ||     // Drow
                // Axfell don't like Cleaven and Drow
                (nPlayerTeam == 2 && (nPCTeam == 1 ||       // Cleaven
                                      nPCTeam == 4 )) ||    // Drow
                // Ranzington don't like Drow
                (nPlayerTeam == 3 && (nPCTeam == 4)) ||     // Drow
                // Drow don't like Axfell, Cleaven, Ranzington and Shilar
                (nPlayerTeam == 4 && ( nPCTeam == 1 ||      // Cleaven
                                       nPCTeam == 2 ||      // Axfell
                                       nPCTeam == 3 ||      // Shilar
                                       nPCTeam == 5)) ||    // Ranzington
                // Shilar don't like Drow
                (nPlayerTeam == 5 && (nPCTeam == 4))        // Drow
               )
            {
               if(GetLocalInt(oPlayer, "CURRENT_PVP_STANCE") == 2 || GetLocalInt(oPC, "CURRENT_PVP_STANCE") == 2) //J. Persinne; hostility is no longer the default unless one of the players is
               {                                                                                                  //flagged for PvP.
                   SetPCDislike (oPlayer, oPC);
                   SetPCDislike (oPC, oPlayer);
               }
               else
               {
                   SetPCLike(oPlayer, oPC);
                   SetPCLike(oPC, oPlayer);
               }
            }
        }
        oPC = GetNextPC();
    }
}

int AnphUpdatePlayerTeam (object oPC)
{

    int nFaction;
    for (nFaction = 1; nFaction < (ANPH_NUMBER_OF_FACTIONS + 1); nFaction++)
    {
       //if (!GetIsObjectValid(GetObjectByTag(GetLocalString(oModule, "FACTION_0" + IntToString(nFaction) + "_FACTIONOBJECT"))));
    }

    CheckPlayerTeam (oPC);

    return 1;
}

void AnphSendCorpseHome (object oPC)
{
    string sName=GetName(oPC);
    string sCDK=GetPCPublicCDKey(oPC);
    string sID=sName+sCDK;
    string sFaction;
    object oDeathCorpse;
    object oHeadstone;
    int iPlace;
    object oPlace;
    string sTeam;
    object oWaypt;
    location oLoc;
    object oOldDC;

    if (GetItemPossessedBy(oPC, "axfellwarriorrin")!= OBJECT_INVALID)
    {
        sFaction = "Axfell";
    }
    if (GetItemPossessedBy(oPC, "cleavenmilitiari")!= OBJECT_INVALID)
    {
        sFaction = "Cleaven";
    }

    oDeathCorpse = GetLocalObject(oModule,"DeathCorpse"+sID);

    sTeam = AnphGetPlayerTeam (oPC);
    oHeadstone = GetObjectByTag(sTeam + "Headstone");
    iPlace = GetLocalInt (oHeadstone, "current-place");
    if (iPlace >= 18)
        iPlace = 0;

    WriteTimestampedLogEntry ("Creating corpse at home.");

    iPlace++;
    SetLocalInt (oHeadstone, "current-place", iPlace);
    oWaypt = GetObjectByTag (sTeam + "Corpse" + IntToString (iPlace));
    if (!GetIsObjectValid (oWaypt))
    {
        WriteTimestampedLogEntry ("Invalid waypt for corpse move!");
        return;
    }
    oLoc = GetLocation (oWaypt);
    // We now have the location of where this corpse should
    // be put, and the corpse itself, just have to move it.
    // FIXME: Destroy contents?
    oOldDC = oDeathCorpse;

    oDeathCorpse=CreateObject (OBJECT_TYPE_PLACEABLE, "DeathCorpse",
                               oLoc);

// Make a new PC Token to put on the new Death Corpse
    object oDeadMan = CreateItemOnObject ("PlayerCorpse",
                                          oDeathCorpse);
    SetLocalObject(oDeadMan,"Owner",oPC);
    SetLocalString(oDeadMan,"Name",sName);
    SetLocalString(oDeadMan,"Key", sCDK);
    SetLocalObject(oDeadMan,"DeathCorpse",oDeathCorpse);
    SetLocalString (oDeadMan, "Faction", sFaction);
    //SetLocalInt(oDeadMan,"Alignment",GetLocalInt(oDropped,"Alignment"));
    //SetLocalString(oDeadMan,"Deity",GetLocalString(oDropped,"Deity"));
    SetLocalObject(oModule,"DeathCorpse"+sName+sCDK,oDeathCorpse);
    SetLocalObject(oModule,"PlayerCorpse"+sName+sCDK,oDeadMan);
    SetLocalObject(oDeathCorpse,"Owner",oPC);
    SetLocalString(oDeathCorpse,"Name",sName);
    SetLocalString(oDeathCorpse,"Key",sCDK);
    SetLocalObject(oDeathCorpse,"PlayerCorpse",oDeadMan);
    SetLocalString (oDeathCorpse, "Faction", sFaction);

    // destroy the old corpse, and everything in it.
    object oCT = GetLocalObject (oOldDC, "PlayerCorpse");
    DestroyObject (oCT);

    object oItem = GetFirstItemInInventory (oOldDC);
    while (GetIsObjectValid (oItem))
    {
        DestroyObject (oItem);
        oItem = GetNextItemInInventory (oOldDC);
    }

    DestroyObject(oOldDC);
}

//------------------------------------------------------------------------------
// This function hands out items for nFaction while destroying all other Faction items if possessed
void GiveFactionItems(object oPC, int nFaction)
{
    object oModuleule = GetModule();
    object oItem;
    object oFactionRing;
    int nCount;
    for (nCount = 1; nCount < (ANPH_NUMBER_OF_FACTIONS + 1); nCount++)
    {
       if (nCount != nFaction)
       {
          oItem = GetItemPossessedBy (oPC, GetLocalString(oModuleule, "FACTION_0" + IntToString(nCount) + "_RING"));
          if (GetIsObjectValid(oItem))
             DestroyObject(oItem);
          oItem = GetItemPossessedBy (oPC, GetLocalString(oModuleule, "FACTION_0" + IntToString(nCount) + "_KEY"));
          if (GetIsObjectValid(oItem))
             DestroyObject(oItem);
          oItem = GetItemPossessedBy (oPC, GetLocalString(oModuleule, "FACTION_0" + IntToString(nCount) + "_HORN"));
          if (GetIsObjectValid(oItem))
             DestroyObject(oItem);
          oItem = GetItemPossessedBy (oPC, GetLocalString(oModuleule, "FACTION_0" + IntToString(nCount) + "_SPECIAL_OBJECT"));
          if (GetIsObjectValid(oItem))
             DestroyObject(oItem);
       }
    }

    oItem = GetItemPossessedBy (oPC, GetLocalString(oModuleule, "FACTION_0" + IntToString(nFaction) + "_RING"));
    if (!GetIsObjectValid (oItem))
    {
        oFactionRing = CreateItemOnObject(GetLocalString(oModuleule, "FACTION_0" + IntToString(nFaction) + "_RING"), oPC); //J. Persinne; we now equip the ring when we receive it.
        AssignCommand(oPC, ActionDoCommand(ActionEquipItem(oFactionRing, INVENTORY_SLOT_LEFTRING)));
    }

    oItem = GetItemPossessedBy (oPC, GetLocalString(oModuleule, "FACTION_0" + IntToString(nFaction) + "_KEY"));
    if (!GetIsObjectValid (oItem))
    {
        CreateItemOnObject(GetLocalString(oModuleule, "FACTION_0" + IntToString(nFaction) + "_KEY"), oPC);
    }

    oItem = GetItemPossessedBy (oPC, GetLocalString(oModuleule, "FACTION_0" + IntToString(nFaction) + "_HORN"));
    if (!GetIsObjectValid (oItem))
    {
        CreateItemOnObject(GetLocalString(oModuleule, "FACTION_0" + IntToString(nFaction) + "_HORN"), oPC);
    }

    if(GetLocalString(oModuleule, "FACTION_0" + IntToString(nFaction) + "_SPECIAL_OBJECT") != "")
    {
       oItem = GetItemPossessedBy (oPC, GetLocalString(oModuleule, "FACTION_0" + IntToString(nFaction) + "_SPECIAL_OBJECT"));
       if (!GetIsObjectValid (oItem))
       {
          CreateItemOnObject(GetLocalString(oModuleule, "FACTION_0" + IntToString(nFaction) + "_SPECIAL_OBJECT"), oPC);
       }
    }
}

/* This function is needed for existing PCs to be compatible with the new items */
void RecreateFactionItems(object oPC, int iTeam)
{
   object oItem;
   switch (iTeam)
   {
   case 1:
      oItem = GetItemPossessedBy (oPC, "CleavenMilitiaRing");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      oItem = GetItemPossessedBy (oPC, "CleavenGateKey");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      oItem = GetItemPossessedBy (oPC, "WarningHorn");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      DelayCommand(2.0, GiveFactionItems(oPC, 1));
      break;
   case 2:
      oItem = GetItemPossessedBy (oPC, "AxfellWarriorRing");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      oItem = GetItemPossessedBy (oPC, "AxfellGateKey");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      oItem = GetItemPossessedBy (oPC, "WarningHorn");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      DelayCommand(2.0, GiveFactionItems(oPC, 2));
      break;
   case 3:
      oItem = GetItemPossessedBy (oPC, "RanzingtonCitizenRing");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      oItem = GetItemPossessedBy (oPC, "RanzingtonGateKey");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      oItem = GetItemPossessedBy (oPC, "WarningHorn");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      DelayCommand(2.0, GiveFactionItems(oPC, 3));
      break;
   case 4:
      oItem = GetItemPossessedBy (oPC, "DrowRing");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      oItem = GetItemPossessedBy (oPC, "DrowGateKey");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      oItem = GetItemPossessedBy (oPC, "WarningHorn");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      oItem = GetItemPossessedBy (oPC, "FarieFire");
      if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
      DelayCommand(2.0, GiveFactionItems(oPC, 4));
      break;
   }
}

//------------------------------------------------------------------------------
//Destroys all faction items
void DestroyAllFactionItems(object oPC){
    object oMod = GetModule();
    object oItem;
    int nCount;
    for(nCount = 1; nCount < ANPH_NUMBER_OF_FACTIONS + 1; nCount++){
        oItem = GetItemPossessedBy (oPC, GetLocalString(oMod, "FACTION_0" + IntToString(nCount) + "_RING"));
        if(GetIsObjectValid(oItem))
            DestroyObject(oItem);

        oItem = GetItemPossessedBy (oPC, GetLocalString(oMod, "FACTION_0" + IntToString(nCount) + "_KEY"));
        if(GetIsObjectValid(oItem))
            DestroyObject(oItem);

        oItem = GetItemPossessedBy (oPC, GetLocalString(oMod, "FACTION_0" + IntToString(nCount) + "_HORN"));
        if(GetIsObjectValid(oItem))
            DestroyObject(oItem);

        oItem = GetItemPossessedBy (oPC, GetLocalString(oMod, "FACTION_0" + IntToString(nCount) + "_SPECIAL_OBJECT"));
        if(GetIsObjectValid(oItem))
            DestroyObject(oItem);
    }
}
void AnphSendWarningCall0 (object oPC)
{
    if(!GetIsOfFaction(oPC, FACTION_AXFELL) && !GetIsOfFaction(oPC, FACTION_CLEAVEN))
    {
        SendMessageToPC(oPC, "<c¥¥¥>[Server] You must select a faction in order to use faction horn signals.");
        return;
    }

    string sPCTeam;
    string sTeam = AnphGetPlayerTeam (oPC);
    object oArea = GetArea (oPC);
    AnphSendMessageToTeam (sTeam, "<cþ× >[Player] "+GetName(oPC)+" has sighted enemy movement in "
                           +GetName(oArea)+"!</c>");

    SendMessageToAllDMs("*** " + GetName (oPC) + " (" + sTeam + ") has sighted enemy movement in " + GetName (oArea) + "! ***");
    SignalEvent(oPC, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    object oPlayer;
    oPlayer = GetFirstPC ();
    object oPC = GetFirstPC();
    while (GetIsObjectValid (oPlayer) == TRUE)
    {
        sPCTeam = AnphGetPlayerTeam (oPlayer);
        if (sPCTeam == sTeam)
        {
            AssignCommand (oPlayer, PlaySound("as_an_wolfhowl1"));
        }
        oPlayer = GetNextPC ();
    }


}
void AnphSendWarningCall1 (object oPC)
{
    if(!GetIsOfFaction(oPC, FACTION_AXFELL) && !GetIsOfFaction(oPC, FACTION_CLEAVEN))
    {
        SendMessageToPC(oPC, "<c¥¥¥>[Server] You must select a faction in order to use faction horn signals.");
        return;
    }

    string sPCTeam;
    string sTeam = AnphGetPlayerTeam (oPC);
    object oArea = GetArea (oPC);
    AnphSendMessageToTeam (sTeam, "<cþ× >[Player] "+GetName(oPC)+" requests that reinforcements be sent to "
                           +GetName(oArea)+"!</c>");

    SendMessageToAllDMs("*** " + GetName (oPC) + " (" + sTeam + ") requests that reinforcements be sent to " + GetName (oArea) + "! ***");
    SignalEvent(oPC, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    object oPlayer;
    oPlayer = GetFirstPC ();
    object oPC = GetFirstPC();
    while (GetIsObjectValid (oPlayer) == TRUE)
    {
        sPCTeam = AnphGetPlayerTeam (oPlayer);
        if (sPCTeam == sTeam)
        {
            AssignCommand (oPlayer, PlaySound("al_pl_x2wardrum2"));
        }
        oPlayer = GetNextPC ();
    }


}
void AnphSendWarningCall2 (object oPC)
{
    if(!GetIsOfFaction(oPC, FACTION_AXFELL) && !GetIsOfFaction(oPC, FACTION_CLEAVEN))
    {
        SendMessageToPC(oPC, "<c¥¥¥>[Server] You must select a faction in order to use faction horn signals.");
        return;
    }

    string sPCTeam;
    string sTeam = AnphGetPlayerTeam (oPC);
    object oArea = GetArea (oPC);
    AnphSendMessageToTeam (sTeam, "<cþ× >[Player] "+GetName(oPC)+" reports all clear in "
                           +GetName(oArea)+"!</c>");

    SendMessageToAllDMs("*** " + GetName (oPC) + " (" + sTeam + ") reports all clear in " + GetName (oArea) + "! ***");
    SignalEvent(oPC, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    object oPlayer;
    oPlayer = GetFirstPC ();
    object oPC = GetFirstPC();
    while (GetIsObjectValid (oPlayer) == TRUE)
    {
        sPCTeam = AnphGetPlayerTeam (oPlayer);
        if (sPCTeam == sTeam)
        {
            AssignCommand (oPlayer, PlaySound("as_cv_eulpipe1"));
        }
        oPlayer = GetNextPC ();
    }


}

void AnphSendExpeditionCall (object oPC)
{
    if(!GetIsOfFaction(oPC, FACTION_AXFELL) && !GetIsOfFaction(oPC, FACTION_CLEAVEN))
    {
        SendMessageToPC(oPC, "<c¥¥¥>[Server] You must select a faction in order to use faction horn signals.");
        return;
    }

    string sPCTeam;
    string sTeam = AnphGetPlayerTeam (oPC);
    object oArea = GetArea (oPC);

    /*string sGender;
    if(GetGender(oPC) == GENDER_FEMALE)
        sGender = "her";
    else
        sGender = "him";*/

    AnphSendMessageToTeam (sTeam, "<cþ× >[Player] "+GetName(oPC)+" requests companions for an expedition at " +GetName(oArea)+"!");

    //SendMessageToAllDMs("*** " + GetName (oPC) + " (" + sTeam + ") reports all clear in " + GetName (oArea) + "! ***");
    //SignalEvent(oPC, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    object oPlayer;
    oPlayer = GetFirstPC ();
    object oPC = GetFirstPC();
    while (GetIsObjectValid (oPlayer) == TRUE)
    {
        sPCTeam = AnphGetPlayerTeam (oPlayer);
        if (sPCTeam == sTeam)
        {
            AssignCommand (oPlayer, PlaySound("al_pl_x2wardrum2"));
        }
        oPlayer = GetNextPC ();
    }


}
/* Test void main() to be able to compile the script */

//void main(){}

