#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    effect eBlind = EffectBlindness();
    effect eSave = EffectConcealment(58,MISS_CHANCE_TYPE_VS_RANGED);
    effect eVis = EffectVisualEffect(VFX_DUR_BLIND);
    object oTarget;
    float fDelay = 0.5;
    oTarget = GetEnteringObject();
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSave, oTarget, RoundsToSeconds(2)));
    if(!MothGetIsFortAlly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF,GetSpellId()));
        if(!MyResistSpell(oCaster, oTarget))
        {
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_SPELL,oCaster))
            {
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, RoundsToSeconds(2)));
            }
        }
    }
}
