#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,FALSE,TRUE,FALSE,TRUE,FALSE,FALSE,TRUE,FALSE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectRegenerate(5,6.0),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSeeInvisible(), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellResistanceIncrease(44), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_AURA_NEGATIVE_ENERGY), OBJECT_SELF);

    SetListeningPatterns();
    GenerateNPCTreasure();

}
