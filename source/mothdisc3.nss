void main()
{
object oPC = GetLastUsedBy();
object oTarget;
object oTarget2;
object oTarget3;
object oTarget4;
object oTarget5;
object oTarget6;
object oTarget7;
object oTargetNew;
object oSpawnNew;
location lTargetNew;
object oMod = GetModule();
string sPC = GetName(oPC);
oTarget = GetObjectByTag("mothsmoke1");
oTarget2 = GetObjectByTag("mothsmoke2");
oTarget3 = GetObjectByTag("mothsmoke3");
oTarget4 = GetObjectByTag("mothsmoke4");
oTarget5 = GetObjectByTag("mothsmoke5");
oTarget6 = GetObjectByTag("mothmainpipe");
oTarget7 = GetObjectByTag("mothcompartment1a");
oTargetNew = GetWaypointByTag("mothcompartment2new");
lTargetNew = GetLocation(oTargetNew);
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
DelayCommand(0.5,FloatingTextStringOnCreature("<cAiá>"+sPC+" turned the water flow off all together.</c>", oPC));
DelayCommand(1.0,DestroyObject(oTarget));
DelayCommand(1.0,DestroyObject(oTarget2));
DelayCommand(1.0,DestroyObject(oTarget3));
DelayCommand(1.0,DestroyObject(oTarget4));
DelayCommand(1.0,DestroyObject(oTarget5));
DelayCommand(1.0,DestroyObject(oTarget6));
DestroyObject(oTarget7);
oSpawnNew = CreateObject(OBJECT_TYPE_PLACEABLE, "door001", lTargetNew);
}
