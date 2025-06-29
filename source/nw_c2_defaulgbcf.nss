#include "anph_treas_gen"
#include "NW_I0_GENERIC"

void main()
{
    MothGiveNPCBuff();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_BLINDNESS), OBJECT_SELF);
    SetListeningPatterns();
    CashLevel = 20;
    MagicLevel = 30;
    GenerateNPCTreasure();
}


