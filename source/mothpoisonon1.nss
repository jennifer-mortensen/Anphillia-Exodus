int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) >= 2 || GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) >= 3 ) return TRUE;
else{return FALSE;}
}

