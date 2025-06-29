#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,TRUE,TRUE,TRUE);
    SetListeningPatterns();
    CashLevel = 55;
    MagicLevel = 100;
    GenerateNPCTreasure();
}


