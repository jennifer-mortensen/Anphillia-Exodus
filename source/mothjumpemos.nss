void main()
{
object oPC = GetPCSpeaker();
object oTarget;
location lTarget;
oTarget = GetWaypointByTag("mothintoemosxxx");
lTarget = GetLocation(oTarget);
if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
AssignCommand(oPC, ClearAllActions());
DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
oTarget = oPC;
int nInt;
nInt = GetObjectType(oTarget);
if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_EVIL_HELP), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_EVIL_HELP), GetLocation(oTarget));
}
