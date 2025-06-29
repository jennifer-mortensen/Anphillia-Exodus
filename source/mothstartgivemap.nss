int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetItemPossessedBy(oPC, "nolose_ctoken") != OBJECT_INVALID) return FALSE;
return TRUE;
}
