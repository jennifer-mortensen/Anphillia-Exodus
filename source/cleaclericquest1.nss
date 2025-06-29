int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetLocalInt(oPC, "CleavenClericQuest") != 0) return FALSE;
return TRUE;
}
