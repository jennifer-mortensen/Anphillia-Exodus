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
    RemoveEffectsFromSpell(oTarget, 594);
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
    int nStr = GetAbilityScore(oTarget, ABILITY_STRENGTH);
    int nStrengthIncrease = (nStr - 18) * -1;
    if( nStrengthIncrease < 0 )
    {
        nStrengthIncrease = 0;
    }
    effect eVis1 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVis2 = EffectVisualEffect(VFX_IMP_PULSE_HOLY_SILENT);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eStrength = EffectAbilityIncrease(ABILITY_STRENGTH, nStrengthIncrease);
    effect eHP = EffectTemporaryHitpoints(nCasterLevel);
    effect eAttack = EffectAttackIncrease(nAttackIncrease);
    effect eAttackMod = EffectModifyAttacks(nExtraAttacks);
    effect eDur = EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN);
    effect eLink = EffectLinkEffects(eAttack, eAttackMod);
    eLink = EffectLinkEffects(eLink, eDur);
    if( nStrengthIncrease > 0 )
    {
        eLink = EffectLinkEffects(eLink, eStrength);
    }
    int nMetaMagic = GetMetaMagicFeat();
    if( nMetaMagic == METAMAGIC_EXTEND )
    {
        nCasterLevel *= 2;
    }
    //If Epic Minotauren
    if(GetAppearanceType(OBJECT_SELF) == 119)
    {
        int nShifter = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
        nCasterLevel == nShifter/2;
        int iTimer = GetLocalInt(OBJECT_SELF, "mothpowermino");
        if (iTimer == TRUE)
        {
        FloatingTextStringOnCreature("<c ее>*No Divine Power Focus!*</c>",OBJECT_SELF,FALSE);
        SendMessageToPC(OBJECT_SELF, "<cеее>[Server] You do not have enough focus right now.</c>");
        return;
        }
        if (iTimer == FALSE)
        {
        DelayCommand(0.7, FloatingTextStringOnCreature("<c ее>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
        DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<cеее>[Server] Divine Power Focus is lost!</c>"));
        SetLocalInt(OBJECT_SELF, "mothpowermino", TRUE);
        DelayCommand(60.0, DeleteLocalInt(OBJECT_SELF, "mothpowermino"));
        DelayCommand(60.0, FloatingTextStringOnCreature("<c ее>*Divine Power Focus Regained!*</c>",OBJECT_SELF,FALSE));
        }
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DIVINE_POWER, FALSE));
    oTarget = OBJECT_SELF;
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    RemoveEffectsFromSpell(oTarget, 594);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCasterLevel));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nCasterLevel));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}

