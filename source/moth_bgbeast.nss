#include "x2_inc_spellhook"
#include "nw_i0_spells"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eRaise;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_IMP_MAGIC_PROTECTION);
    int nDuration = GetLevelByClass(CLASS_TYPE_BLACKGUARD,OBJECT_SELF);
    int nBonus = nDuration/2;
    effect eSR = EffectDamageResistance(DAMAGE_TYPE_COLD,nBonus);
    int nRaise = 2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    eRaise = EffectAbilityIncrease(ABILITY_STRENGTH, nRaise);
    effect eLink = EffectLinkEffects(eRaise, eDur);
    eLink = EffectLinkEffects(eLink, eSR);
    eLink = ExtraordinaryEffect(eLink);
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    TLVFXPillar(VFX_IMP_STARBURST_RED,GetLocation(oTarget), 3, 0.0f, 1.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
