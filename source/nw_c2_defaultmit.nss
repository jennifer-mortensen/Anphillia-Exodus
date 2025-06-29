#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    effect eReg = EffectRegenerate(1,9.0);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eReg,OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectUltravision(), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAttackDecrease(2), OBJECT_SELF);
    MothGiveNPCBuff(OBJECT_SELF,TRUE,FALSE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,TRUE,TRUE);
    SetListeningPatterns();
    CashLevel = 60;
    MagicLevel = 80;
    GenerateNPCTreasure();
}


