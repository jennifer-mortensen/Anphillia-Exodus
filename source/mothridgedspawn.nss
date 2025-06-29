#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,FALSE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,TRUE,TRUE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectACIncrease(1), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTemporaryHitpoints(60), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAttackDecrease(3), OBJECT_SELF);

    SetListeningPatterns();
    CashLevel = 25;
    MagicLevel = 50;
    GenerateNPCTreasure();


}
