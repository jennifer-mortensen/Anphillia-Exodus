#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,FALSE,TRUE);
    SetListeningPatterns();
    CashLevel = 20;
    MagicLevel = 40;
    GenerateNPCTreasure();
}


