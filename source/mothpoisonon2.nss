int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) >= 3 || GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) >= 5 ) return TRUE;
else{return FALSE;}
}

