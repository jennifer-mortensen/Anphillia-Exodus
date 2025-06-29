#include "x2_inc_switches"
void main()
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSeeInvisible(),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSkillIncrease(SKILL_LISTEN,12),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSkillIncrease(SKILL_SPOT,12),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAttackIncrease(10),OBJECT_SELF);
    ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
