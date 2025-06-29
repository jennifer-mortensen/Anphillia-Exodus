#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_SLOW);
    effect eSlow = EffectAbilityDecrease(ABILITY_STRENGTH,4);
    effect eLink = EffectLinkEffects(eVis, eSlow);
    float fDelay;
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
         if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster,oTarget))
            {
                if(!GetHasSpellEffect(SPELL_VINE_MINE_HAMPER_MOVEMENT, oTarget))
                {
                SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_VINE_MINE_HAMPER_MOVEMENT));
                fDelay = GetRandomDelay(0.0, 1.0);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,RoundsToSeconds(4)));
                }
            }
        }
        oTarget = GetNextInPersistentObject();
    }
}

