#include "moth_inc_spell2"
void main()
{
   object oZombie = OBJECT_SELF;
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectImmunity(IMMUNITY_TYPE_DEATH),oZombie);
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN),oZombie);
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectImmunity(IMMUNITY_TYPE_DOMINATE),oZombie);
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTrueSeeing(),oZombie);
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_ORANGE),oZombie);
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_SMOKE),oZombie);
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_FLAG_RED),oZombie);
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(2000),oZombie);
   int nRoll = d100();
   object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oZombie, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_HAS_SPELL_EFFECT,325);
   if(nRoll>15)
   {
   oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oZombie, 1, CREATURE_TYPE_IS_ALIVE, TRUE);
   }
   DelayCommand(1.0,PlaySound("clock_tick"));
   ActionMoveToObject(oTarget,TRUE,0.5);
   ActionAttack(oTarget);
   DelayCommand(15.0,DestroyObject(oZombie));
}
