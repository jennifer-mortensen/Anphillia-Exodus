#include "nw_i0_spells"
#include "x0_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    effect eVisc2 = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
    effect eVisc1 = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eVisc3 = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    effect eVis = EffectLinkEffects(eVisc2, eVisc1);
    eVis = EffectLinkEffects(eVis, eVisc3);
    effect eVise2 = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
    effect eVise1 = EffectVisualEffect(VFX_FNF_WORD);
    effect eVise3 = EffectVisualEffect(VFX_FNF_UNDEAD_DRAGON);
    effect eVis2 = EffectLinkEffects(eVise2, eVise1);
    eVis2 = EffectLinkEffects(eVis2, eVise3);
    effect eDamage;
    effect eLink;
    int nDamage;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis2, GetLocation(OBJECT_SELF));
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
    float fDelay;
    while(GetIsObjectValid(oTarget))
    {
        fDelay = 4.8;
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        nDamage = d100(2);
        eDamage = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
        eLink = EffectLinkEffects(eVis, eDamage);
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
    }
}
