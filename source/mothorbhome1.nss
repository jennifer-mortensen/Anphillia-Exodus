#include "anph_inc"
void main()
{
    object oPC = GetLastUsedBy();
    if (!GetIsPC(oPC)) return;
    object oTarget;
    object oDestroy;
    location lTarget;
    string sName = "orb" + GetPCPlayerName(oPC);
    oDestroy = GetObjectByTag(sName);
    lTarget = GetLocalLocation(oPC, "mothorb");
    if (GetAreaFromLocation(lTarget)==OBJECT_INVALID)
    {
        string sStartTag = GetLocalString(GetModule(), "FACTION_0" + IntToString(AnphGetPlayerTeamInt(oPC)) + "_STARTLOCATION");
        object oTarget = GetObjectByTag(sStartTag);
        AssignCommand (oPC, JumpToObject (oTarget));
        return;
    }
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToLocation(lTarget));
    SetLocalLocation(oPC, "mothorb", GetLocation(oPC));
    DestroyObject(oDestroy, 3.0);
    DelayCommand(4.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL),lTarget));
}

