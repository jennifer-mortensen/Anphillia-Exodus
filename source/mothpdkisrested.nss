int StartingConditional()
{

    if(GetLocalInt(GetPCSpeaker(), "mothpdkblocksummon") == TRUE)
        return FALSE;
    return TRUE;
}
