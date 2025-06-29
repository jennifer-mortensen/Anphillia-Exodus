#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    MothGiveNPCBuff();
    SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);
    SetListeningPatterns();
    CashLevel = 20;
    CreateNPCBag = TRUE;
    GenerateNPCTreasure();
}


