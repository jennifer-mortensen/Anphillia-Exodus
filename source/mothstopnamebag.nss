int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetItemPossessedBy(oPC, "mothnamebag") == OBJECT_INVALID) return FALSE;
return TRUE;
}
