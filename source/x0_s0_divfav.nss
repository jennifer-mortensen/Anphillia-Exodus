#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    int nLvl = MothGetCasterLevel(OBJECT_SELF);
    int nScale =  nLvl / 4;
    if (nScale < 1)
        nScale = 1;
    if (nScale >4)
        nScale = 4;
    //object oScroll = GetSpellCastItem();
    //if(!GetIsObjectValid(oScroll))
    //{
    if(GetHasFeat(FEAT_STRENGTH_DOMAIN_POWER,OBJECT_SELF) || GetLocalInt(OBJECT_SELF, "MOTHSTRENGTHDOMAIN") == TRUE)
    {
        nScale +=1;
        SendMessageToPC(OBJECT_SELF, "Strength Domain grants you +1 extra bonus!");
    }
    //}
    int nDuration = 1; // * Duration 1 turn
    effect eDamage = EffectDamageIncrease(nScale, DAMAGE_TYPE_MAGICAL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = OBJECT_SELF;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 414, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamage, oTarget, TurnsToSeconds(nDuration));

}
