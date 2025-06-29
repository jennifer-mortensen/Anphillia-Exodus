#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eMind = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    effect eSneak = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
    effect eBlind = EffectImmunity(IMMUNITY_TYPE_BLINDNESS);
    effect eDeath = EffectImmunity(IMMUNITY_TYPE_DEATH);
    effect eDur1 = EffectVisualEffect(463);
    effect eDur2 = EffectVisualEffect(VFX_DUR_GLOW_GREY);
    effect eDur3 = EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_BLACK);
    int nDuration = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
    float fDuration = IntToFloat(nDuration)*2;
    effect eLink = EffectLinkEffects(eMind, eSneak);
    eLink = EffectLinkEffects(eLink, eBlind);
    eLink = EffectLinkEffects(eLink, eDeath);
    eLink = EffectLinkEffects(eLink, eDur1);
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eDur3);
    eLink = ExtraordinaryEffect(eLink);
    oTarget = OBJECT_SELF;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,fDuration);
}
