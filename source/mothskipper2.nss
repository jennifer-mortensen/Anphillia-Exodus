void main()
{
object oPC = GetPCSpeaker();
object oTarget;
object oStone1 = GetObjectByTag("mothdustskip1");
object oStone2 = GetObjectByTag("mothdustskip2");
object oStone3 = GetObjectByTag("mothdustskip3");
object oStone4 = GetObjectByTag("mothdustskip4");
location lTarget;
oTarget = GetWaypointByTag("mothskip11");
lTarget = GetLocation(oTarget);
if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
AssignCommand(oPC, ClearAllActions());
DelayCommand(4.5, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
oTarget = oPC;
int nInt;
nInt = GetObjectType(oTarget);
if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oTarget));
DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oStone1)));
DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oStone2)));
DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oStone3)));
DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oStone4)));
}
