#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,FALSE,TRUE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellImmunity(SPELL_DARKNESS), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellImmunity(192), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellImmunity(352), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellImmunity(731), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellImmunity(228), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_BLINDNESS), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_ENTANGLE), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_PARALYSIS), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_SLOW), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellResistanceIncrease(34), OBJECT_SELF);

    SetListeningPatterns();
    GenerateNPCTreasure();


}
