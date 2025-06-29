#include "nw_i0_spells"

void main()
{
    //J. Persinne, 6/22/09; code rewritten from scratch for legibility.

    //---------------------------------------------------------------------|
    // War Domain now provides the following bonuses:                      |
    //   +1 AB, +1 AB / 5 Cleric Levels (Capped at +4)                     |
    //   +1 Bludgeoning Damage, +1 Damage / 5 Cleric Levels (Capped at +3) |
    //   +1 DEX/CON, +1 DEX/CON / 10 Cleric Levels                         |
    //   X/+5 DR; X equals 5 + 1/5 Cleric Levels                           |
    //   Duration = 5 Hours + 1 Hour / Charisma Modifier                   |
    //---------------------------------------------------------------------|

    int nClericLevels = GetLevelByClass(CLASS_TYPE_CLERIC);
    int nDuration = GetAbilityModifier(ABILITY_CHARISMA) + 5;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);

    //Attack Increase
    int nAB = 1 + nClericLevels / 5;
    if(nAB > 4)
        nAB = 4;
    effect eAB = EffectAttackIncrease(nAB);

    //Damage Increase
    int nDamage = 1 + nClericLevels / 5;
    if(nDamage > 3)
        nDamage = 3;
    switch(nDamage)
    {
        case 1:
            nDamage = DAMAGE_BONUS_1;
            break;
        case 2:
            nDamage = DAMAGE_BONUS_2;
            break;
        case 3:
            nDamage = DAMAGE_BONUS_3;
            break;
    }
    effect eDamage = EffectDamageIncrease(nDamage, DAMAGE_TYPE_BLUDGEONING);

    //Ability Increases
    int nAbilityIncrease = 1 + nClericLevels / 10;
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, nAbilityIncrease);
    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, nAbilityIncrease);

    //Damage Reduction
    int nDR = 5 + nClericLevels / 5;
    effect eDR = EffectDamageReduction(nDR, DAMAGE_POWER_PLUS_FIVE);

    //Create the War Domain effect
    effect eLink;
    eLink = EffectLinkEffects(eAB, eDamage);
    eLink = EffectLinkEffects(eLink, eCon);
    eLink = EffectLinkEffects(eLink, eDex);
    eLink = EffectLinkEffects(eLink, eDR);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = ExtraordinaryEffect(eLink);

    //Apply the effect
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(nDuration));
}
