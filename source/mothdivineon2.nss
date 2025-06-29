int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPC) >= 6 || GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) >= 6 ||GetLevelByClass(CLASS_TYPE_PALADIN, oPC) >= 9 ) return TRUE;
else{return FALSE;}
}
