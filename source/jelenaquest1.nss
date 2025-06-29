/*int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetHitDice(oPC) <  45) return FALSE;

return TRUE;
}*/

int StartingConditional()
{
if (GetLocalInt(GetModule(), "JelenaQuest") == TRUE) return FALSE;
return TRUE;
}
