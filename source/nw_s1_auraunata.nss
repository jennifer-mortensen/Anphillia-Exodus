#include "NW_I0_SPELLS"
void main()
{
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eFear = EffectFrightened();
    effect eLink = EffectLinkEffects(eVis, eFear);
    object oTarget = GetEnteringObject();
    int nDuration = GetHitDice(GetAreaOfEffectCreator());
    int nRacial = GetRacialType(oTarget);
    int nDC = 10 + GetHitDice(GetAreaOfEffectCreator())/3;
    if(!MothGetIsFortAlly(oTarget, GetAreaOfEffectCreator()))
    {
        nDuration = (nDuration / 3) + 1;
        if(nRacial == RACIAL_TYPE_ANIMAL)
        {
            SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELLABILITY_AURA_UNNATURAL));
            if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            }
        }
    }
}
