int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetLocalInt(oPC, "MothFortune") == 4) return TRUE;
else return FALSE;
}
