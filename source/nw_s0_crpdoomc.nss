#include "MOTH_INC_SPELL2"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    int nLevel = MothGetCasterLevel(oCaster);
    effect eVis = EffectVisualEffect(VFX_IMP_DISEASE_S);
    effect eImmobile = EffectCutsceneImmobilize();
    float fDuration = RoundsToSeconds(2);
    object oTarget;
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
         if(!MothGolemWalkImmunityHigh(oTarget))
         {
         if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster,oTarget))
           {
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_CREEPING_DOOM));
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_TRAP, oCaster))
              {
              DelayCommand(0.6,MothBugsAttack(oTarget,nLevel));
              }
           }
        }
        oTarget = GetNextInPersistentObject();
    }
}
