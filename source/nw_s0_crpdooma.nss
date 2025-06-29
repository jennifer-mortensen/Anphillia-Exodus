#include "MOTH_INC_SPELL2"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    int nLevel = MothGetCasterLevel(oCaster);
    float fDuration = RoundsToSeconds(2);
    effect eVis = EffectVisualEffect(VFX_IMP_DISEASE_S);
    effect eImmobile = EffectCutsceneImmobilize();
    object oTarget;
    oTarget = GetEnteringObject();
    if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
    {
       if(!MothGolemWalkImmunityHigh(oTarget))
       {
        if(!MothGetIsTargetMyPet(oCaster,oTarget))
        {
         SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_CREEPING_DOOM));
         if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_TRAP, oCaster))
         {
           DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eImmobile,oTarget,fDuration));
           DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oTarget,fDuration));
         }
         DelayCommand(0.6,MothBugsAttack(oTarget,nLevel));
        }
       }
   }
}
