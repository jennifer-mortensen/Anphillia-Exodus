#include "MOTH_INC_SPELL2"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    int nLevel = MothGetCasterLevel(oCaster);
    float fDuration = RoundsToSeconds(2);
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
    effect eImmobile = EffectEntangle(); //J. Persinne; changed to entangle effect.
    object oTarget;
    oTarget = GetEnteringObject();
    if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
    {
         SignalEvent(oTarget, EventSpellCastAt(oCaster, 108));
         if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_TRAP, oCaster))
         {
          DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eImmobile,oTarget,fDuration));
          DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oTarget,fDuration));
         }
         DelayCommand(0.6,MothSpiderAttack(oTarget,nLevel));
   }
}
