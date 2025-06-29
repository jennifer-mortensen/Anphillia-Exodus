#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    object oTarget;
    effect eFall = EffectKnockdown();
    effect eVis = EffectVisualEffect(VFX_DUR_GLOW_GREY);
    float fDelay;
    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) && !MothGolemWalkImmunityLow(oTarget))
        {
            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster,oTarget))
            {
             fDelay = GetRandomDelay(0.0, 2.0);
             if(!MyResistSpell(oCaster, oTarget))
               {
                if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, MothFogDC(), SAVING_THROW_TYPE_TRAP, oCaster, fDelay))
                {
                    RemoveEffectsFromSpell(oTarget, SPELL_GREASE);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 4.0));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFall, oTarget, 4.0));
                }
               }
            }
        }
        oTarget = GetNextInPersistentObject();
    }
}

