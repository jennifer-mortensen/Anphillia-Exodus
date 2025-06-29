#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,TRUE);
    SetListeningPatterns();
    CashLevel = 40;
    MagicLevel = 40;
    GenerateNPCTreasure();
}


