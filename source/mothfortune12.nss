int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetLocalInt(oPC, "MothFortune") == 12) return TRUE;
else return FALSE;
}
