#include "anph_treas_gen"
#include "x0_i0_anims"
#include "x2_inc_switches"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,FALSE,TRUE);
    effect ePer = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,OBJECT_SELF);
    ePer = SupernaturalEffect(ePer);

    SetListeningPatterns();
    GenerateNPCTreasure();


}
