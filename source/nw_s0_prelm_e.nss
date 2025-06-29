#include "x2_inc_toollib"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oPC = OBJECT_SELF;
    location lTarget = GetSpellTargetLocation();
    object oTarget = GetSpellTargetObject();
    if (GetIsObjectValid(oTarget))
    {
        MothHoldGreatOak(oTarget,oPC,GetSpellId());
        return;
    }
    else
    {
    object oArea = GetArea(oPC);
    if(GetIsAreaInterior(oArea))
    {
     return;
    }
    effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE,"nw_s0_prelm_ax","nw_s0_prelm_ax","nw_s0_prelm_ax");
    int nDuration = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
    effect eVis = EffectVisualEffect(481);
    int iTimer = GetLocalInt(oPC, "MOTHGREATOAK");
    if (iTimer == TRUE)
    {
    FloatingTextStringOnCreature("<cðøþ>*No School focus!*</c>",oPC,FALSE);
    SendMessageToPC(oPC, "<c¥¥¥>[Server] This spell can only be cast once per day. The spell is lost.</c>");
    return;
    }
    if (iTimer == FALSE)
    {
        if(!GetHasFeat(FEAT_EPIC_DRUID,oPC))
        {
        SendMessageToPC(oPC, "<c¥¥¥>[Server] Only Epic Druids can summon an Ent. The spell is lost.</c>");
        return;
        }
        if(MothGetIsLocationClear(oPC,lTarget))
        {
        MothSpawnGreatOak(oPC,lTarget);
        DelayCommand(1.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration*2)));
        DelayCommand(5.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis,lTarget));
        SetLocalInt(oPC, "MOTHGREATOAK", TRUE);
        }
        else
        {
         SendMessageToPC(oPC,"<c¥¥¥>[Server] Not a valid location. The location needs to be clear of any other objects!</c>");
         return;
        }
    }
    }
}
