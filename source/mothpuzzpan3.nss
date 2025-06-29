int StartingConditional()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
if ((GetTag(OBJECT_SELF) == "mothcorepanel3")) return TRUE;
if ((GetLocalInt(oMod, "mothpanel1") == 2)) return TRUE;
else return FALSE;
}

