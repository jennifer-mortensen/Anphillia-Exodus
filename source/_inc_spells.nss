//::///////////////////////////////////////////////
//:: Spells Function Library
//:: _inc_spells
//:://////////////////////////////////////////////
/*
    Contains functions for use with spells.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 25, 2009
//:://////////////////////////////////////////////

#include "_inc_gen"

//These constants must correspond to the line number of spells in spells.2da.
const int SPELL_AURA_VS_ALIGNMENT = 323;
const int SPELL_DEFLECTING_FORCE = 774;

//Grants oTarget regeneration equal to 10% of the healing amount +10% per 10 druid levels divided over the span of 10 rounds.
void ApplyDruidHoT(int nHealAmount, object oTarget, object oCaster = OBJECT_SELF);
//Recalculates healing amount with regards to the Heal Domain. Call this function with all 'cure' and 'heal' spells.
int GetDomainAdjustedHeal(int nHealAmount, object oCaster = OBJECT_SELF);
//Removes all spell damage shields from oTarget. Call this whenever a spell damage shield is about to be applied.
void RemoveSpellDamageShields(object oTarget = OBJECT_SELF);

//::///////////////////////////////////////////////
//:: ApplyDruidHoT
//:://////////////////////////////////////////////
/*
    Grants oTarget regeneration equal to 10% of
    the healing amount +10% per 10 druid levels
    over the span of 10 rounds.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 25, 2009
//:://////////////////////////////////////////////
void ApplyDruidHoT(int nHealAmount, object oTarget, object oCaster = OBJECT_SELF)
{
    effect eEffect;
    effect eRegen;
    float fRegenModifier;
    int nEffectId;
    int nDruidLevels;
    int nRegenAmount;
    int nTerminateLoop = FALSE;
    int nVFX;

    if(GetHasSpellEffect(SPELL_MASS_HEAL, oTarget) || GetHasSpellEffect(SPELL_HEAL, oTarget) || GetHasSpellEffect(SPELL_NATURES_BALANCE, oTarget)) //Remove old regen effects.
    {
        eEffect = GetFirstEffect(oTarget);
        while(GetIsEffectValid(eEffect) && nTerminateLoop == FALSE)
        {
            nEffectId = GetEffectSpellId(eEffect);
            if(nEffectId == SPELL_MASS_HEAL || nEffectId == SPELL_HEAL || nEffectId == SPELL_NATURES_BALANCE)
            {
                RemoveEffect(oTarget, eEffect);
                nTerminateLoop = TRUE;
            }
            eEffect = GetNextEffect(oTarget);
        }
    }
    nVFX = VFX_DUR_GLOW_GREEN;
    nDruidLevels = GetLevelByClass(CLASS_TYPE_DRUID, oCaster);
    if((GetIsPolymorphType(OBJECT_SELF, ANPH_POLYMORPH_TYPE_LIZARDFOLK_MALE_EPIC) || GetIsPolymorphType(OBJECT_SELF, ANPH_POLYMORPH_TYPE_LIZARDFOLK_FEMALE_EPIC))
        && GetIsPC(OBJECT_SELF)) //Epic Lizardfolk Whipmasters add their shifter levels to their druid levels when calculating regeneration.
    {
        nDruidLevels += GetLevelByClass(CLASS_TYPE_SHIFTER, oCaster);
    }
    nDruidLevels = nDruidLevels / 10;
    fRegenModifier = 0.1 + (0.1 * IntToFloat(nDruidLevels));
    nRegenAmount = FloatToInt(IntToFloat(nHealAmount) * fRegenModifier) / 10;
    eRegen = EffectRegenerate(nRegenAmount, 6.0);
    eRegen = EffectLinkEffects(eRegen, EffectVisualEffect(nVFX));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oTarget, 60.0);
}

//::///////////////////////////////////////////////
//:: GetDomainAdjustedHeal
//:://////////////////////////////////////////////
/*
    Recalculates healing amount with regards to
    the Heal Domain. Call this function with all
    'cure' and 'heal' spells.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 25, 2009
//:://////////////////////////////////////////////
int GetDomainAdjustedHeal(int nHealAmount, object oCaster = OBJECT_SELF)
{
    if(!GetHasFeat(FEAT_HEALING_DOMAIN_POWER, oCaster))
        return nHealAmount;

    int nClericLevels = GetLevelByClass(CLASS_TYPE_CLERIC, oCaster);
    float fDomainBonus = 0.10 + (IntToFloat(nClericLevels / 10) / 10); //J. Persinne; healing domain grants a bonus of 10% plus an additional 10% per 10 cleric levels.
    int nDomainAdjustedHeal = nHealAmount + FloatToInt(nHealAmount * fDomainBonus);

    return nDomainAdjustedHeal;
}

//::///////////////////////////////////////////////
//:: RemoveSpellDamageShields
//:://////////////////////////////////////////////
/*
    Removes all spell damage shields from oTarget.
    Call this whenever a spell damage shield is
    about to be applied.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 25, 2009
//:://////////////////////////////////////////////
void RemoveSpellDamageShields(object oTarget = OBJECT_SELF)
{
    effect eDamageShield = GetFirstEffect(oTarget);
    int nSpellId = GetEffectSpellId(eDamageShield);

    while(GetIsEffectValid(eDamageShield))
    {
        switch(nSpellId)
        {
            case SPELL_ELEMENTAL_SHIELD:
            case SPELL_DEFLECTING_FORCE:
            case SPELL_MESTILS_ACID_SHEATH:
            case SPELL_DEATH_ARMOR:
            case SPELL_WOUNDING_WHISPERS:
            case SPELL_HOLY_AURA:
            case SPELL_UNHOLY_AURA:
            case SPELL_AURA_VS_ALIGNMENT:
            case SPELL_INVISIBILITY_SPHERE:

            RemoveEffect(oTarget, eDamageShield); //Cases "fall through" without a break statement; if nSpellID corresponds to any of the above, we'll end up here. This is a bit more efficient than
                                                  //a lengthy if statement.
        }
        eDamageShield = GetNextEffect(oTarget);
        nSpellId = GetEffectSpellId(eDamageShield);
    }
}
