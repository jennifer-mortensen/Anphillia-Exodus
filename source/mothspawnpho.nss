void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
object oTarget;
object oTarget2;
effect eEffect;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("Phobos1");
oTarget2 = GetObjectByTag("phobos1");
lTarget = GetLocation(oTarget);
eEffect = EffectKnockdown();
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "phobos1", lTarget);
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oSpawn));
}

