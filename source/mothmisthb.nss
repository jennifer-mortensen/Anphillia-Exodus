#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    effect eBlind = EffectBlindness();
    effect eVis = EffectVisualEffect(VFX_DUR_BLIND);
    effect eSave = EffectConcealment(58,MISS_CHANCE_TYPE_VS_RANGED);
    object oTarget;
    float fDelay = 0.5;
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSave, oTarget, RoundsToSeconds(3)));
        if(!MothGetIsFortAlly(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));
            if(!MyResistSpell(oCaster, oTarget))
            {
              if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_SPELL,oCaster))
              {
               DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
               DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, RoundsToSeconds(2)));
              }
            }
        }
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    }
}
