/*
    Determines the course of action to be taken
    on a user defined event.
*/
#include "hc_inc"
#include "anph_inc"
#include "anph_persist_inc"

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


            oMarker = GetObjectByTag (GetTag (OBJECT_SELF) + "Marker");
            SetAnphString (GetTag (OBJECT_SELF) + "_team", "");

            oPC = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

            SpeakString ("OK, OK, we give already!");

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
