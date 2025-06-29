#include "x0_i0_spells"
void main()
{
    if(!GetHasFeatEffect(FEAT_EMPTY_BODY))
    {
        object oTarget = OBJECT_SELF;
        int nLvl = GetLevelByClass(CLASS_TYPE_MONK, OBJECT_SELF) + (GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF)/2);
        int nConcealment = 50;
        effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
        effect eCover = EffectConcealment(nConcealment);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eCover, eVis);
        eLink = EffectLinkEffects(eLink, eDur);
        eLink = SupernaturalEffect(eLink);
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_EMPTY_BODY, FALSE));
        int nDuration = nLvl-4;
        RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
}
}
