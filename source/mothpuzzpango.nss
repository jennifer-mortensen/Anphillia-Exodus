void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
int nInt;
nInt = GetLocalInt(oMod, "mothpanel1");
nInt += 1;
SetLocalInt(oMod, "mothpanel1", nInt);
FloatingTextStringOnCreature("<cýõæ>The button clicks into place. You seem to have pressed the correct one.</c>", oPC);
DelayCommand(2.0, DestroyObject(OBJECT_SELF));
nInt=GetLocalInt(oMod, "mothpanel1");
if (nInt >= 4)
   {
   SendMessageToPC(oPC, "<cýõæ>A small hatch opens on the pillar, revealling a compartment. Inside you find a book.</c>");
   CreateItemOnObject("motherrynbook", oPC);
   }
}

