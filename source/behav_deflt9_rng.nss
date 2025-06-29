#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff();
    SetCombatCondition(X0_COMBAT_FLAG_RANGED);
    SetListeningPatterns();
    GenerateNPCTreasure();

}
