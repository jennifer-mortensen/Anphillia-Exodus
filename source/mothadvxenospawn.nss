#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    MothGiveNPCBuff();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_WHITE),OBJECT_SELF);
    SetListeningPatterns();
    CashLevel = 20;
    MagicLevel = 50;
    GenerateNPCTreasure();
}


