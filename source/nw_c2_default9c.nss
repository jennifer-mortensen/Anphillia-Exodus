#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    MothGiveNPCBuff();
    SetListeningPatterns();
    MagicLevel = 60;
    CashLevel = 15;
    CreateNPCBag = FALSE;
    GenerateNPCTreasure();
}


