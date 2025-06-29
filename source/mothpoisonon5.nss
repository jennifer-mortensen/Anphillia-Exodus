int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) >= 11 || GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) >= 15 ) return TRUE;
else{return FALSE;}
}

