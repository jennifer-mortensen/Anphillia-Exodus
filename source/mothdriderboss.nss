#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,FALSE,TRUE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellImmunity(SPELL_DARKNESS), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectRegenerate(5,6.0),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSeeInvisible(), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellResistanceIncrease(34), OBJECT_SELF);
    SetListeningPatterns();
    GenerateNPCTreasure();

}
