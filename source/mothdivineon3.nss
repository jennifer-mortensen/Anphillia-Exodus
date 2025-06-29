int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPC) >= 11 || GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) >= 11 ||GetLevelByClass(CLASS_TYPE_PALADIN, oPC) >= 20 ) return TRUE;
else{return FALSE;}
}
