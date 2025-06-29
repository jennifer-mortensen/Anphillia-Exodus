int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) >= 5 || GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) >= 9 ) return TRUE;
else{return FALSE;}
}

