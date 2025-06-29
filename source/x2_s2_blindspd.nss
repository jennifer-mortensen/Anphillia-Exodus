#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    if (GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT, oTarget) == TRUE)
    {
        RemoveSpellEffects(SPELL_EXPEDITIOUS_RETREAT, OBJECT_SELF, oTarget);
    }
    if (GetHasSpellEffect(SPELL_HASTE, oTarget) == TRUE)
    {
        RemoveSpellEffects(SPELL_HASTE, OBJECT_SELF, oTarget);
    }
    if (GetHasSpellEffect(SPELL_MASS_HASTE, oTarget) == TRUE)
    {
        RemoveSpellEffects(SPELL_MASS_HASTE, OBJECT_SELF, oTarget);
    }
    if (GetHasSpellEffect(GetSpellId(), oTarget) == TRUE)
    {
        RemoveSpellEffects(GetSpellId(), OBJECT_SELF, oTarget);
    }
    int nCasterLvl = GetHitDice(OBJECT_SELF)+20;
    effect eHaste = EffectHaste();
    effect eVis = EffectVisualEffect(460);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHaste, eDur);
    eLink = ExtraordinaryEffect(eLink);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCasterLvl*2));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}


