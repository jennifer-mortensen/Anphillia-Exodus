#include "anph_treas_gen"
#include "NW_I0_GENERIC"

void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,TRUE,TRUE,FALSE,TRUE,FALSE,FALSE,FALSE,TRUE,TRUE,TRUE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(25),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAttackDecrease(4),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAttackDecrease(2),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageDecrease(5),OBJECT_SELF);
    SetListeningPatterns();
    CashLevel = 20;
    MagicLevel = 40;
    GenerateNPCTreasure();
}


