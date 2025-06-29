void main()
{
object oPC = GetLastUsedBy();
object oMod = GetModule();
if (!GetIsPC(oPC)) return;
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0f, 120.0f));
SetLocalInt(oMod, "LONGTERMCARE"+GetName(oPC)+GetPCPublicCDKey(oPC), 2);
DelayCommand(2.0,FloatingTextStringOnCreature("<cðøþ>*You sit down for a moment on the comfortable bedroll.*</c>",oPC));
}
