int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetHasFeat(FEAT_POINT_BLANK_SHOT,oPC)==TRUE) return TRUE;
else{return FALSE;}
}
