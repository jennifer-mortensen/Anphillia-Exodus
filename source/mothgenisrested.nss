int StartingConditional()
{

    if(GetLocalInt(GetPCSpeaker(), "mothgenblocksummon") == TRUE)
        return FALSE;
    return TRUE;
}
