int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetHasFeat(FEAT_WEAPON_FOCUS_SHURIKEN,oPC)==TRUE) return TRUE;
else{return FALSE;}
}
