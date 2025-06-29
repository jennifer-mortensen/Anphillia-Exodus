int StartingConditional()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
if ((GetTag(OBJECT_SELF) == "mothcorepanel1")) return TRUE;
if ((GetLocalInt(oMod, "mothpanel1") == 0)) return TRUE;
else return FALSE;
}

