#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 4);
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eInt;
    effect eAttack;
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    int nDuration = 24;
    int nDamage = DAMAGE_BONUS_2d6;
    int nRoll = d4();
    int nMetaMagic = GetMetaMagicFeat();
    if(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION) == oTarget)
    {
        if(!GetHasSpellEffect(SPELL_AWAKEN))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_AWAKEN, FALSE));
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage = DAMAGE_BONUS_2d8;
                nRoll = 4;
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nRoll = nRoll + nRoll / 2;
            }
            else if (nMetaMagic == METAMAGIC_EXTEND)
            {
                nDuration = nDuration *2;
            }
            eAttack = EffectAttackIncrease(nRoll);
            eInt = EffectDamageIncrease(nDamage,DAMAGE_TYPE_BLUDGEONING);
            effect eLink = EffectLinkEffects(eStr, eCon);
            eLink = EffectLinkEffects(eLink, eAttack);
            eLink = EffectLinkEffects(eLink, eInt);
            eLink = EffectLinkEffects(eLink, eDur);
            eLink = ExtraordinaryEffect(eLink);
            RemoveEffectsFromSpell(oTarget, GetSpellId());
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
        }
    }
}
