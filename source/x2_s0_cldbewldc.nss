#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    effect eBlind = EffectBlindness();
    effect eVis = EffectVisualEffect(VFX_DUR_BLIND);
    object oTarget;
    float fDelay;
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
        {
            fDelay = GetRandomDelay(0.75, 1.75);
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_CLOUD_OF_BEWILDERMENT));
            if(!MyResistSpell(oCaster, oTarget))
            {
                if (!GetHasSpellEffect(SPELL_CLOUD_OF_BEWILDERMENT,oTarget))
                {
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_MIND_SPELLS,oCaster))
                    {
                      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, RoundsToSeconds(4)));
                    }
                }
            }
        }
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    }
}
