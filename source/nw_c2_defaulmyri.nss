#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectRegenerate(5,6.0),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_GREY), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellResistanceIncrease(39), OBJECT_SELF);

    SetListeningPatterns();
    GenerateNPCTreasure();


}
