#include "nw_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_ASSASSIN,OBJECT_SELF);
    int nTotalCharacterLevel = GetHitDice(OBJECT_SELF);
    int nBAB = GetBaseAttackBonus(OBJECT_SELF);
    int nEpicPortionOfBAB = ( nTotalCharacterLevel - 19 ) / 2;
    if ( nEpicPortionOfBAB < 0 )
    {
        nEpicPortionOfBAB = 0;
    }
    int nExtraAttacks = 0;
    if ( nTotalCharacterLevel > 20 )
    {
        if( nBAB - nEpicPortionOfBAB < 11 )
        {
            nExtraAttacks = 2;
        }
        else if( nBAB - nEpicPortionOfBAB > 10 && nBAB - nEpicPortionOfBAB < 16)
        {
            nExtraAttacks = 1;
        }
    }
    int nStr = GetAbilityScore(oTarget, ABILITY_STRENGTH);
    int nStrengthIncrease = (nStr - 18) * -1;
    if( nStrengthIncrease < 0 )
    {
        nStrengthIncrease = 0;
    }
    effect eVis1 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVis2 = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eStrength = EffectAbilityIncrease(ABILITY_STRENGTH, nStrengthIncrease);
    effect eAB = EffectAttackIncrease(nCasterLevel/3);
    effect eAttackMod = EffectModifyAttacks(nExtraAttacks);
    effect eDur = EffectVisualEffect(VFX_DUR_IOUNSTONE_RED);
    effect eLink = EffectLinkEffects(eDur, eAttackMod);
    if( nStrengthIncrease > 0 )
    {
        eLink = EffectLinkEffects(eLink, eStrength);
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    oTarget = OBJECT_SELF;
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCasterLevel*2));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oTarget, RoundsToSeconds(nCasterLevel*2));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}



