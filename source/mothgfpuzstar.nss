int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if((GetLocalInt(oPC, "MothHasGFPuzzle") == 1))
        return FALSE;

    return TRUE;
}
