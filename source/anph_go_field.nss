#include "anph_db_inc"
#include "hc_inc"
#include "anph_inc"


void main()
{
    object oPC;
    object oRing;
    object oItem;
    object oLife;

    oPC = GetLastUsedBy();
    object oMaster = GetMaster(oPC);
    if (GetIsObjectValid(oMaster))
       return;

    // Update player faction
    CheckPlayerTeam (oPC);

    /* End of ATS Removal Stuff */
    location lNew;
    lNew = AnphGetCampaignLocation ("LastPlayerLocation", oPC);

    if (GetIsObjectValid (GetAreaFromLocation (lNew)))
    {
        AssignCommand (oPC, ClearAllActions ());
        AssignCommand (oPC, JumpToLocation (lNew));
        return;
    }


    // Original script if the above fails.

    object oTarget = OBJECT_INVALID;
    // Special treatment for drow
    if (GetIsObjectValid (GetItemPossessedBy(oPC, GetLocalString(GetModule(), "FACTION_04_RING"))))
    {
        if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0)
        {
           oTarget = GetObjectByTag("DrowPriestStartLocation");
        }
        else
        {
           oTarget = GetObjectByTag("DrowStartLocation");
        }
    }
    // else just select the normal starting location
    else
    {
       oTarget = GetObjectByTag(GetLocalString(GetModule(), "FACTION_0" + IntToString(AnphGetPlayerTeamInt(oPC)) + "_STARTLOCATION"));
    }
    if (GetIsObjectValid(oTarget))
    {
       AssignCommand (oPC, JumpToObject(oTarget));
       return;
    }

    if (GetXP (oPC) > 1)
        oTarget = GetObjectByTag("CheatersLocation");
    else
        oTarget = GetObjectByTag("ChooseSideLocation");

    AssignCommand(oPC,JumpToObject(oTarget));
}
