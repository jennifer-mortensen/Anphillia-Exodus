#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    effect eVis = EffectVisualEffect(VFX_IMP_SLOW);
    effect eSlow = EffectAbilityDecrease(ABILITY_STRENGTH,4);
    effect eLink = EffectLinkEffects(eVis, eSlow);
    object oTarget = GetEnteringObject();
    float fDelay = GetRandomDelay(1.0, 2.2);
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster,oTarget))
    {
        if(!MothGolemWalkImmunityHigh(oTarget))
        {
          SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_VINE_MINE_HAMPER_MOVEMENT));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,RoundsToSeconds(4));
        }
    }
}
