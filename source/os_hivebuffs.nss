#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,FALSE,FALSE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);
    SetListeningPatterns();
    CashLevel = 25;
    MagicLevel = 35;
    GenerateNPCTreasure();
}
