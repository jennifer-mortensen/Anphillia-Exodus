int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetLocalInt(oPC, "FirstHorseCall") != TRUE) return FALSE;
if(GetLocalInt(oPC, "HasMount") != TRUE)return FALSE;
return TRUE;
}
