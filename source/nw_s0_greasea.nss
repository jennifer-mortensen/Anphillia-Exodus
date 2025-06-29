#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    int nMetaMagic = GetMetaMagicFeat();
    object oCaster = GetAreaOfEffectCreator();
    effect eVis = EffectVisualEffect(VFX_IMP_SLOW);
    effect eVis2 = EffectVisualEffect(VFX_DUR_GLOW_GREY);
    effect eSlow = EffectKnockdown();
    effect eLink = EffectLinkEffects(eVis, eSlow);
    object oTarget = GetEnteringObject();
    float fDelay = GetRandomDelay(1.0, 2.2);
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster,oTarget))
    {
        if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) && !MothGolemWalkImmunityLow(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_GREASE));
            if(!MyResistSpell(oCaster, oTarget))
            {
             if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, MothFogDC(), SAVING_THROW_TYPE_TRAP, oCaster, fDelay))
               {
                RemoveEffectsFromSpell(oTarget, SPELL_GREASE);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget,4.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,4.0);
               }
            }
        }
    }
}
