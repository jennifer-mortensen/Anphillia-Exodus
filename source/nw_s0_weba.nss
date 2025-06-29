#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{

    object oCaster = GetAreaOfEffectCreator();
    effect eWeb = EffectEntangle();
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
    effect eLink = EffectLinkEffects(eWeb, eVis);
    object oTarget = GetEnteringObject();
    effect eSlow = EffectAbilityDecrease(ABILITY_DEXTERITY,4);
    if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster)  && !MothGetIsTargetMyPet(oCaster,oTarget))
    {
        if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) && !MothGolemWalkImmunityMedium(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_WEB));
            if(!MyResistSpell(oCaster, oTarget))
            {
                if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, MothFogDC(),SAVING_THROW_TYPE_TRAP,oCaster))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1));
                }
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oTarget);
            }
        }
    }
}
