#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,FALSE,FALSE,FALSE);
    SetListeningPatterns();
    CashLevel = 20;
    MagicLevel = 30;
    GenerateNPCTreasure();
}


