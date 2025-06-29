#include "hc_inc"
#include "anph_inc"
#include "anph_persist_inc"
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
    CheckPlayerTeam (oPC);
    object oTarget = OBJECT_INVALID;
    oTarget = GetObjectByTag(GetLocalString(GetModule(), "FACTION_0" + IntToString(AnphGetPlayerTeamInt(oPC)) + "_STARTLOCATION"));
    if (GetIsObjectValid(oTarget))
    {
       MothSetFactionInt(oPC);
       AssignCommand (oPC, JumpToObject(oTarget));
       return;
    }
    if (GetXP (oPC) > 1)
        oTarget = GetObjectByTag("CheatersLocation");
    else
        oTarget = GetObjectByTag("ChooseSideLocation");
    AssignCommand(oPC,JumpToObject(oTarget));
}
