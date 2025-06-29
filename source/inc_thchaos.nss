// Increases AB of the owner of the owner by ATTACK_INCREASE, for DURATION rounds.
void thChaos1(int ATTACK_INCREASE, int DURATION)
{
object oSpellOrigin = OBJECT_SELF;

if (ATTACK_INCREASE < 1)
{
ATTACK_INCREASE = 1;
}

if (DURATION < 1)
{
DURATION = 1;
}

effect eEffect = EffectAttackIncrease(ATTACK_INCREASE);
effect eVis = EffectVisualEffect(VFX_DUR_GLOW_RED);

PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oSpellOrigin, RoundsToSeconds(DURATION));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oSpellOrigin, RoundsToSeconds(DURATION));
}

// Grants regeneration REGEN_INCREASE, for DURATION rounds.
void thChaos2(int REGEN_INCREASE, int DURATION)
{
object oSpellOrigin = OBJECT_SELF;

if (REGEN_INCREASE < 1)
{
REGEN_INCREASE = 1;
}

if (DURATION < 1)
{
DURATION = 1;
}

effect eEffect = EffectRegenerate(REGEN_INCREASE, 2.0);
effect eVis = EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oSpellOrigin, RoundsToSeconds(DURATION));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oSpellOrigin);
}

// Applys a damage shield to the owner, for DURATION rounds, which damages attackers for 1d6 + DAMAGE_BASE.
void thChaos3(int DAMAGE_BASE, int DURATION)
{
object oSpellOrigin = OBJECT_SELF;

if (DURATION < 1)
{
DURATION = 1;
}

effect eEffect = EffectDamageShield(DAMAGE_BASE, DAMAGE_BONUS_1d6, DAMAGE_TYPE_BLUDGEONING);
effect eVis = EffectVisualEffect(VFX_DUR_GLOW_BROWN);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oSpellOrigin, RoundsToSeconds(DURATION));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oSpellOrigin, RoundsToSeconds(DURATION));
}

// Applys a cutscene immobilize effect to the attacker for DURATION seconds.
void thChaos4(float DURATION)
{
object oSpellTarget = GetSpellTargetObject();

if (DURATION < 1.0)
{
DURATION = 1.0;
}

effect eEffect = EffectCutsceneImmobilize();
effect eVis1 = EffectVisualEffect(VFX_DUR_ICESKIN);
effect eVis2 = EffectBeam(VFX_BEAM_SILENT_COLD, OBJECT_SELF, BODY_NODE_CHEST);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oSpellTarget, DURATION);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis1, oSpellTarget, DURATION);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oSpellTarget, DURATION);
}

//Applys a miss chance to the attacker equal to MISS_CHANCE for DURATION rounds.
void thChaos5(int MISS_CHANCE, int DURATION)
{
object oSpellTarget = GetSpellTargetObject();

if (MISS_CHANCE < 10)
{
MISS_CHANCE = 10;
}

if (DURATION < 1)
{
DURATION = 1;
}

effect eEffect = EffectMissChance(MISS_CHANCE);
effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oSpellTarget, RoundsToSeconds(DURATION));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oSpellTarget, RoundsToSeconds(DURATION));
}
