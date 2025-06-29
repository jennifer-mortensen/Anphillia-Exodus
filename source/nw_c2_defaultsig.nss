#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,FALSE,TRUE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSeeInvisible(), OBJECT_SELF);
    effect ePer = EffectVisualEffect(VFX_DUR_GLOW_GREEN);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,ePer,OBJECT_SELF);
    effect eReg = EffectRegenerate(1,9.0);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eReg,OBJECT_SELF);

    SetListeningPatterns();
    GenerateNPCTreasure();


}
