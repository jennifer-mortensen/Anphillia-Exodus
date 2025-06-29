int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if((GetLocalInt(oPC, "MothHasSerisPuzzle") == 1))
        return FALSE;

    return TRUE;
}
