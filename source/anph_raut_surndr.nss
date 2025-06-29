/*
    Determines the course of action to be taken
    on a user defined event.
*/
#include "hc_inc"
#include "anph_inc"


void main()
{
    int nUser;


    nUser = GetUserDefinedEventNumber ();
    // SpeakString("Ouch, that hurts - " + IntToString (nUser));
    /* Damaged */
    if(nUser == 1006)
    {
        string sTeam;
        object oPC;
        object oMarker;
        int nMaxHP = GetMaxHitPoints();
        int nCurrHP = GetCurrentHitPoints();

        if((nCurrHP * 3) <= nMaxHP)
        {

            sTeam = AnphGetPlayerTeam (oPC);

            oMarker = GetObjectByTag (GetTag (OBJECT_SELF) + "Marker");
            SetPersistentString (oMarker, "team", "");

            oPC = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

            SpeakString ("You win! We stop! We stop! You " + sTeam + "s crazy!", TALKVOLUME_SHOUT);

            if (sTeam == GetLocalString(oMod, "FACTION_02_NAME"))
            {
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_02_NAME"), OBJECT_SELF, 100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_01_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_03_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_04_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_05_NAME"), OBJECT_SELF, -100);
            } else if (sTeam == GetLocalString(oMod, "FACTION_01_NAME"))
            {
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_01_NAME"), OBJECT_SELF, 100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_02_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_03_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_04_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_05_NAME"), OBJECT_SELF, -100);
            } else if (sTeam == GetLocalString(oMod, "FACTION_04_NAME"))
            {
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_01_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_02_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_03_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_04_NAME"), OBJECT_SELF, 100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_05_NAME"), OBJECT_SELF, -100);
            } else if (sTeam == GetLocalString(oMod, "FACTION_03_NAME"))
            {
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_01_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_02_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_03_NAME"), OBJECT_SELF, 100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_04_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_05_NAME"), OBJECT_SELF, -100);
            } else if (sTeam == GetLocalString(oMod, "FACTION_05_NAME"))
            {
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_01_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_02_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_03_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_04_NAME"), OBJECT_SELF, -100);
                UpdateTeamFaction (GetLocalString(oMod, "FACTION_05_NAME"), OBJECT_SELF, 100);
            }

            ClearAllActions();
            AnphSurrender (OBJECT_SELF, oPC);

            SurrenderToEnemies();
            //AssignCommand(GetLastAttacker(), ClearAllActions());
            // * SHOULDN'T HAVE TO DO THIS
            //SetIsTemporaryEnemy(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC));
            //SetLocalInt(OBJECT_SELF,"Generic_Surrender",1)   ;
            SpeakOneLinerConversation();
            //SetLocalInt(OBJECT_SELF,"NW_L_DOTHISONCE",1);

        }
    }

}
