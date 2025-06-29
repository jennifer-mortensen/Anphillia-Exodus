int StartingConditional()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
if ((GetTag(OBJECT_SELF) == "mothcorepanel4")) return TRUE;
if ((GetLocalInt(oMod, "mothpanel1") == 3)) return TRUE;
else return FALSE;
}

