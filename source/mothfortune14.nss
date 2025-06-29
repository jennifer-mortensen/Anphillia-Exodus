int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetLocalInt(oPC, "MothFortune") == 14) return TRUE;
else return FALSE;
}
