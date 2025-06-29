#include "nw_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_HARPER,OBJECT_SELF);
    effect eVis1 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVis2 = EffectVisualEffect(VFX_IMP_PULSE_WIND);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eStrength = EffectAbilityIncrease(ABILITY_STRENGTH,2);
    effect eAB = EffectAttackIncrease(nCasterLevel/5 + 1);
    effect eAttackMod = EffectSavingThrowIncrease(SAVING_THROW_ALL,4,SAVING_THROW_TYPE_DEATH);
    effect eDur = EffectVisualEffect(VFX_DUR_IOUNSTONE_BLUE);
    effect eLink = EffectLinkEffects(eDur, eAttackMod);
    int nDamageBonus = nCasterLevel / 5;

    if(nDamageBonus > 0)
    {
        switch(nDamageBonus)
        {
            case 1:
                nDamageBonus = DAMAGE_BONUS_1;
                break;
            case 2:
                nDamageBonus = DAMAGE_BONUS_2;
                break;
        }
        effect eDamageBonus = EffectDamageIncrease(nDamageBonus, DAMAGE_TYPE_POSITIVE);
        eLink = EffectLinkEffects(eLink, eDamageBonus);
    }

    eLink = EffectLinkEffects(eLink, eStrength);
    eLink = EffectLinkEffects(eLink, eAB);
    eLink = ExtraordinaryEffect(eLink);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    oTarget = OBJECT_SELF;
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(5 + nCasterLevel / 2));
    //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oTarget, RoundsToSeconds(nCasterLevel*2));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}



