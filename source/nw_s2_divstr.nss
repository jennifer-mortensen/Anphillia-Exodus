#include "nw_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oTarget = GetSpellTargetObject();
    effect eStr;
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLvl = GetLevelByClass(CLASS_TYPE_CLERIC);
    /*if(nCasterLvl<6)
    {
     SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You have too few Cleric levels to channel this Domain Power!</c>");
     return;
    }*/
    int nModify = (nCasterLvl/4) + GetAbilityModifier(ABILITY_CHARISMA);
    int nDuration = 5 + GetAbilityModifier(ABILITY_CHARISMA);
    if (nModify < 1)
     nModify = 1;
    if (nModify > 12)
     nModify = 12;
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_DIVINE_STRENGTH, FALSE));
    eStr = EffectAbilityIncrease(ABILITY_STRENGTH,nModify);
    effect eLink = EffectLinkEffects(eStr, eDur);

    //J. Persinne; strength domain power now grants +1 positive damage, plus an additional +1 per 10 cleric levels, as well as +1 AB for cleric level 40.
    int nDamageIncrease;
    nCasterLvl = nCasterLvl / 10;

    switch(nCasterLvl)
    {
        case 0: //Cleric Levels 0 - 9
            nDamageIncrease = DAMAGE_BONUS_1;
            break;
        case 1: //Cleric Levels 10 - 19
            nDamageIncrease = DAMAGE_BONUS_2;
            break;
        case 2: //Cleric Levels 20 - 29
            nDamageIncrease = DAMAGE_BONUS_3;
            break;
        case 3: //Cleric Levels 30 - 39
            nDamageIncrease = DAMAGE_BONUS_4;
            break;
        case 4: //Cleric Level 40
            nDamageIncrease = DAMAGE_BONUS_5;
            eLink = EffectLinkEffects(eLink, EffectAttackIncrease(1));
            break;
    }

    effect eDamageIncrease = EffectDamageIncrease(nDamageIncrease, DAMAGE_TYPE_POSITIVE);
    eLink = EffectLinkEffects(eLink, eDamageIncrease);
    eLink = ExtraordinaryEffect(eLink);

    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration/*+5*/));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
