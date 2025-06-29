#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,FALSE,TRUE,TRUE);
    SetListeningPatterns();
    CashLevel = 30;
    MagicLevel = 30;
    GenerateNPCTreasure();
}
