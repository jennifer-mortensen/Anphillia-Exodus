int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC)>=10) return TRUE;
else{return FALSE;}
}
