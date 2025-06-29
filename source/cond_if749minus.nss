int StartingConditional()
{
    int iResult;

    iResult = (GetGold(GetPCSpeaker()) < 750)? TRUE: FALSE;
    return iResult;
}
