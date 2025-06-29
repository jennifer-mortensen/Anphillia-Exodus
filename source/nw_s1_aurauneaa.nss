#include "NW_I0_SPELLS"
void main()
{
    object oTarget = GetEnteringObject();
    effect eDeath = EffectDeath();
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    if(!MothGetIsFortAlly(oTarget, GetAreaOfEffectCreator()))
    {
        SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELLABILITY_AURA_UNEARTHLY_VISAGE));
        if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_DEATH))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
        }
    }
}
