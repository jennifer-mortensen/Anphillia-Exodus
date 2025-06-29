int StartingConditional()
{
    string sSubrace = GetSubRace(GetPCSpeaker());
    if(sSubrace == "")
        return TRUE;
    return FALSE;
}
