int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oPC)>=2||GetHasFeat(FEAT_TURN_UNDEAD,oPC)==TRUE)return TRUE;
else{return FALSE;}
}
