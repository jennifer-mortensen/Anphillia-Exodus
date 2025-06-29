///::///////////////////////////////////////////////
//:: Default:On Death
//:: NW_C2_DEFAULT7
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Shouts to allies that they have been killed
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 25, 2001
//:://////////////////////////////////////////////
#include "hc_inc_npccorpse"
#include "NW_I0_GENERIC"
#include "hc_inc"

#include "anph_inc"
#include "anph_db_inc"
#include "anph_xp_inc"

void main()
{
    object oKiller = GetLastKiller();
    object oGate4 = GetObjectByTag("mothprojection");
    DelayCommand(1.5, DestroyObject(oGate4));
    ExecuteScript("mothstone1",oKiller);
    // Get a controlled undead's master
    if(GetLocalString(oKiller, "MY_MASTER_IS") != "")
    {
        // Don't reward XP or anything when a summon did the kill
        object oKillerMaster = GetMaster(oKiller);
        oKiller = oKillerMaster;


        string sName = GetLocalString(oKiller, "MY_MASTER_IS");
        object oPC = GetFirstPC();
        while(GetIsObjectValid(oPC))
        {

            if(sName == GetPCPlayerName(oPC))
            {
                oKiller = oPC;
            }
            oPC = GetNextPC();
        }

    }


    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    /*if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }*/
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    else if(GetRacialType(OBJECT_SELF)==RACIAL_TYPE_ANIMAL)
    {
        SetIsDestroyable(FALSE, FALSE, TRUE);
        DelayCommand(30.0,SetIsDestroyable(TRUE, FALSE, TRUE));
    }
    else
        LeaveCorpse();

    AnphRewardXP (OBJECT_SELF, oKiller);
    {
 }
}
