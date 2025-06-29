int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) >= 4 || GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) >= 7 ) return TRUE;
else{return FALSE;}
}

