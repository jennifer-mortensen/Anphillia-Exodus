#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    int nSave = MothGetCasterLevel(oCaster)/20;
    effect eBlind = EffectBlindness();
    effect eSave = EffectSavingThrowDecrease(SAVING_THROW_FORT,1+nSave,SAVING_THROW_TYPE_SPELL);
    effect eVis = EffectVisualEffect(VFX_DUR_BLIND);
    object oTarget;
    float fDelay;
    oTarget = GetEnteringObject();
    if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
    {
        fDelay = GetRandomDelay(0.75, 1.75);
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF,SPELL_CLOUD_OF_BEWILDERMENT));
        if(!MyResistSpell(oCaster, oTarget))
        {
            RemoveEffectsFromSpell(oTarget,SPELL_CLOUD_OF_BEWILDERMENT);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSave, oTarget, RoundsToSeconds(4)));
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_MIND_SPELLS,oCaster))
            {
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, RoundsToSeconds(4)));
            }
        }
    }
}
