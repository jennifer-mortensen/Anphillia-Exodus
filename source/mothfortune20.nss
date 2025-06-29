int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetLocalInt(oPC, "MothFortune") == 20) return TRUE;
else return FALSE;
}
