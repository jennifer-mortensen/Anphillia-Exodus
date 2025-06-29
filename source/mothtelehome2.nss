//After Bemfas has been killed this portal will appear and when it's used
// by a PC it will tele him/her back to Condor's Screm and give them 550 xp.
// It can only be used once per PC.

#include "_inc_xp"

void main()
{
object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
object oTarget;
location lTarget;
oTarget = GetWaypointByTag("mothbackfromplane");
lTarget = GetLocation(oTarget);
if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
AssignCommand(oPC, ClearAllActions());
DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
DelayCommand(0.5, GiveVirtualXPToCreature(oPC, 550));
oTarget = oPC;
int nInt;
nInt = GetObjectType(oTarget);
if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));
}

