int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_MONK,oPC)>=12) return TRUE;
else{return FALSE;}
}
