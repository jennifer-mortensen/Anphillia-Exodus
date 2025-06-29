#include "moth_inc_effects"
void main()
{
    object oPC = GetItemActivator();
    string sArea = GetTag(GetArea(oPC));
    if(sArea == "AxfellFuguePlane" ||
      sArea == "CleavenFuguePlane" ||
      sArea == "ADream_ud")
       {
     return;
       }
    if (!GetIsPC(GetItemActivatedTarget())|| GetIsInCombat(GetItemActivator()))
      {
        SendMessageToPC(GetItemActivator(),"<cðæŒ>*You cannot use this Orb while in combat!*</c>");
        return;
       }
    int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
    if (DoOnce==TRUE) return;
    SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
    object oTarget;
    location lTarget;
    string sName = "orb" + GetPCPlayerName(oPC);
    oTarget = GetObjectByTag("mothorbwaypoint");
    SetLocalLocation(oPC, "mothorb", GetLocation(oPC));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL),oPC);
    AssignCommand(oPC, ClearAllActions());
    DelayCommand(1.1, AssignCommand(oPC, ActionJumpToObject(oTarget)));
    lTarget = GetLocalLocation(oPC, "mothorb");
    CreateObject(OBJECT_TYPE_PLACEABLE, "mothorb2", lTarget,TRUE, sName);
    DelayCommand(4.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL),lTarget));
    MothRemoveCorpses(oPC);
}
