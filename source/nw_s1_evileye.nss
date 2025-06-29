//Deflection Force
#include "nw_i0_spells"
#include "x2_inc_spellhook"
#include "_inc_spells"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (GetIsPC(OBJECT_SELF)==FALSE)
    {
       return;
    }
    object oTarget = GetSpellTargetObject();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nDamage = nDuration/2;
    int nLimit = nDuration * 10;
    effect eStone = EffectDamageReduction(20, DAMAGE_POWER_PLUS_SIX, nLimit);
    effect eShield = EffectDamageShield(nDamage, DAMAGE_BONUS_1d10, DAMAGE_TYPE_COLD);
    effect eVis1 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect eVis2 = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_ORANGE);
    effect eVis3 = EffectVisualEffect(VFX_DUR_ICESKIN);
    effect eVis4 = EffectVisualEffect(VFX_IMP_GLOBE_USE);
    effect eVis5 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVisb = EffectLinkEffects(eVis1, eVis2);
    effect eVis = EffectLinkEffects(eVisb, eVis3);
    effect eLink1 = EffectLinkEffects(eStone, eVis);
    effect eLink = EffectLinkEffects(eLink1, eShield);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    //RemoveEffectsFromSpell(oTarget, GetSpellId());
    RemoveSpellDamageShields();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis4, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis5, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration+10));
}
