int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetLocalInt(oPC, "AxfellLadyQuest") != 0) return FALSE;
return TRUE;
}
