void main()
{
object oPC = GetPCSpeaker();
object oTarget;
oTarget = oPC;
int nInt;
nInt = GetObjectType(oTarget);
if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oTarget));
effect eEffect;
eEffect = EffectDamage(d20(6)+50, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_ENERGY);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);
oTarget = oPC;
nInt = GetObjectType(oTarget);
if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_EVIL), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_EVIL), GetLocation(oTarget));
DelayCommand(2.0, DestroyObject(OBJECT_SELF));
}
