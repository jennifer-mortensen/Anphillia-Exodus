int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetLocalInt(oPC, "HasMount") != TRUE)return FALSE;
return TRUE;
}
