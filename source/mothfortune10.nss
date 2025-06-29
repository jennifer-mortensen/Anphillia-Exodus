int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetLocalInt(oPC, "MothFortune") == 10) return TRUE;
else return FALSE;
}
