int StartingConditional()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
if ((GetTag(OBJECT_SELF) == "mothcorepanel2")) return TRUE;
if ((GetLocalInt(oMod, "mothpanel1") == 1)) return TRUE;
else return FALSE;
}

