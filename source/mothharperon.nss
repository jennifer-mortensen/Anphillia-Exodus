int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_HARPER,oPC)>=5) return TRUE;
else{return FALSE;}
}
