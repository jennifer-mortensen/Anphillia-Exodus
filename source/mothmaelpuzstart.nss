int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if((GetLocalInt(oPC, "MothHasMaelPuzzle") == 1))
        return FALSE;

    return TRUE;
}
