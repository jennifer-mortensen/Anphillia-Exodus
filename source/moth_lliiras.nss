#include "nw_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eStone;
    effect eVis = EffectVisualEffect(VFX_DUR_IOUNSTONE_YELLOW);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink;
    object oTarget = GetSpellTargetObject();
    int nLevel = GetLevelByClass(CLASS_TYPE_HARPER, OBJECT_SELF);
    int nBonus = nLevel*10;
    int nAmount = 100 + nBonus;
    int nDuration = GetLevelByClass(CLASS_TYPE_HARPER,OBJECT_SELF);;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    eStone = EffectDamageReduction(nDuration, DAMAGE_POWER_PLUS_SIX, nAmount);
    eLink = EffectLinkEffects(eStone, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = ExtraordinaryEffect(eLink);
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}
