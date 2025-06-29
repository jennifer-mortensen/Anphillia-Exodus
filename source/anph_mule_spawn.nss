#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    SetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL);
    SetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE);
    effect eEffect = EffectDamageDecrease(40, DAMAGE_TYPE_SLASHING);;
    effect eEffect2 = EffectDamageDecrease(40, DAMAGE_TYPE_PIERCING);
    effect eEffect3 = EffectAttackDecrease(40, ATTACK_BONUS_MISC);
    effect eEffect4 = EffectBlindness();
    effect eEffect5 = EffectDamageDecrease(40, DAMAGE_TYPE_BLUDGEONING);
    eEffect = SupernaturalEffect(eEffect);
    eEffect2 = SupernaturalEffect(eEffect2);
    eEffect3 = SupernaturalEffect(eEffect3);
    eEffect4 = SupernaturalEffect(eEffect4);
    eEffect5 = SupernaturalEffect(eEffect5);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect2, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect3, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect4, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect5, OBJECT_SELF);
    SetAssociateListenPatterns();
    SetListeningPatterns();
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
    SetAssociateState(NW_ASC_DISTANCE_6_METERS);
    SetAssociateStartLocation();
}
