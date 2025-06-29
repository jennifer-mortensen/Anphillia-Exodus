#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,FALSE,TRUE);
    effect ePer = EffectSpellResistanceIncrease(38);
    effect eSee = EffectVisualEffect(VFX_DUR_GLOW_GREEN);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSee,OBJECT_SELF);

    SetListeningPatterns();
    GenerateNPCTreasure();


}
