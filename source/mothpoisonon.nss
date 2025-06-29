int StartingConditional()
{
object oPC = GetPCSpeaker();

if(!GetHasFeat(FEAT_USE_POISON,oPC)) return FALSE;

return TRUE;
}

