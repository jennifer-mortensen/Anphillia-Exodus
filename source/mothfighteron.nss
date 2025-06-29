int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)>=15) return TRUE;
else{return FALSE;}
}
