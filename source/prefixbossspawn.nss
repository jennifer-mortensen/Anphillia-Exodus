#include "anph_treas_gen"
#include "NW_I0_GENERIC"
void main()
{
    MothGiveNPCBuff(OBJECT_SELF,TRUE,FALSE,TRUE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellImmunity(SPELL_DARKNESS), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellImmunity(192), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellImmunity(352), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellImmunity(731), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellImmunity(228), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_BLINDNESS), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_ENTANGLE), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_DEATH), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_GREY), OBJECT_SELF);
    SetListeningPatterns();
    CashLevel = 40;
    MagicLevel = 60;
    GenerateNPCTreasure();
}


