#include "nw_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    RemoveEffectsFromSpell(oTarget, SPELL_DIVINE_POWER);
    RemoveTempHitPoints();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nTotalCharacterLevel = GetHitDice(OBJECT_SELF);
    int nBAB = GetBaseAttackBonus(OBJECT_SELF);
    int nEpicPortionOfBAB = ( nTotalCharacterLevel - 19 ) / 2;
    if ( nEpicPortionOfBAB < 0 )
    {
        nEpicPortionOfBAB = 0;
    }
    int nExtraAttacks = 0;
    int nAttackIncrease = 0;
    if ( nTotalCharacterLevel > 20 )
    {
        nAttackIncrease = 20 + nEpicPortionOfBAB;
        if( nBAB - nEpicPortionOfBAB < 11 )
        {
            nExtraAttacks = 2;
        }
        else if( nBAB - nEpicPortionOfBAB > 10 && nBAB - nEpicPortionOfBAB < 16)
        {
            nExtraAttacks = 1;
        }
    }
    else
    {
        nAttackIncrease = nTotalCharacterLevel;
        nExtraAttacks = ( ( nTotalCharacterLevel - 1 ) / 5 ) - ( ( nBAB - 1 ) / 5 );
    }
    nAttackIncrease -= nBAB;
    if ( nAttackIncrease < 0 )
    {
        nAttackIncrease = 0;
    }
    effect eVis1 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVis2 = EffectVisualEffect(VFX_IMP_PULSE_HOLY_SILENT);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eStrength = EffectAbilityIncrease(ABILITY_STRENGTH, 6);
    effect eHP = EffectTemporaryHitpoints(nCasterLevel*2);
    effect eAttack = EffectAttackIncrease(nAttackIncrease+1);
    effect eAttackMod = EffectModifyAttacks(nExtraAttacks);
    effect eDur = EffectVisualEffect(VFX_DUR_IOUNSTONE_RED);
    effect eDamage = EffectDamageIncrease(DAMAGE_BONUS_3,DAMAGE_TYPE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eAttackMod);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDamage);
    eLink = EffectLinkEffects(eLink, eStrength);
    int nMetaMagic = GetMetaMagicFeat();
    if( nMetaMagic == METAMAGIC_EXTEND )
    {
        nCasterLevel *= 2;
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    oTarget = OBJECT_SELF;
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    RemoveEffectsFromSpell(oTarget, SPELL_DIVINE_POWER);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCasterLevel));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nCasterLevel));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}

