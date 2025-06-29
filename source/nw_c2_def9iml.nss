#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,FALSE,FALSE,TRUE);
    SetListeningPatterns();
    CashLevel = 20;
    MagicLevel = 30;
    GenerateNPCTreasure();
}
