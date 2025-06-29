int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nRace = GetRacialType(oPC);

    if(nRace == RACIAL_TYPE_HALFORC)
        return TRUE;
    return FALSE;
}
