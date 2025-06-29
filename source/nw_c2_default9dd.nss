#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    MothGiveNPCBuff();
    SetListeningPatterns();
    CashLevel = 30;
    MagicLevel = 100;
    CreateNPCBag = TRUE;
    GenerateNPCTreasure();
}


