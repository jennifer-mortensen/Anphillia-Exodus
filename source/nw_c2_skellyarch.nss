#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamageIncrease(DAMAGE_BONUS_1d6,DAMAGE_TYPE_NEGATIVE), OBJECT_SELF);
    SetListeningPatterns();
    GenerateNPCTreasure();


}
