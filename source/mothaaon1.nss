int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC)>=3) return TRUE;
if(GetLevelByClass(CLASS_TYPE_HARPER,oPC)>=2) return TRUE;
else{return FALSE;}
}
