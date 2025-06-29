int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nRace = GetRacialType(oPC);

    if(nRace == RACIAL_TYPE_ELF)
        return TRUE;
    return FALSE;
}
