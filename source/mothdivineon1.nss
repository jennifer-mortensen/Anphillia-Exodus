int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPC) >= 4 || GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) >= 4 || GetLevelByClass(CLASS_TYPE_PALADIN, oPC) >= 7 ) return TRUE;
else{return FALSE;}
}
