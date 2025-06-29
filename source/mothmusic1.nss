void main()
{
object oPC = GetLastOpenedBy();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
object oTarget;
oTarget = GetObjectByTag("");
MusicBackgroundChangeNight(GetArea(oPC), 67);
}
