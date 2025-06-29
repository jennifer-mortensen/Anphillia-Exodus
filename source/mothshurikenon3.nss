int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC)>=21) return TRUE;
else{return FALSE;}
}
