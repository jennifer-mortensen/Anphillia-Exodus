#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{

    object oCaster = GetAreaOfEffectCreator();
    effect eWeb = EffectSlow();
    effect eVis = EffectVisualEffect(VFX_IMP_SLOW);
    effect eLink = EffectLinkEffects(eWeb, eVis);
    object oTarget = GetEnteringObject();
    effect eSlow = EffectAbilityDecrease(ABILITY_DEXTERITY,4);
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster)  && !MothGetIsTargetMyPet(oCaster,oTarget))
    {
        if(!MothGolemWalkImmunityMedium(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_SPIKE_GROWTH));
            if(!MyResistSpell(oCaster, oTarget))
            {
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothFogDC(),SAVING_THROW_TYPE_TRAP,oCaster))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(2));
                }
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oTarget);
            }
        }
    }
}
