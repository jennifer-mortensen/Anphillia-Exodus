int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)>=25) return TRUE;
else{return FALSE;}
}
