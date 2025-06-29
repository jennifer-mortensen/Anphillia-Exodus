int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetHasFeat(FEAT_EPIC_IMPROVED_KI_STRIKE_4,oPC)==TRUE) return TRUE;
if(GetHasFeat(FEAT_EPIC_IMPROVED_KI_STRIKE_5,oPC)==TRUE) return TRUE;
else{return FALSE;}
}
