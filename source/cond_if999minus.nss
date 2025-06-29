int StartingConditional()
{
    int iResult;

    iResult = (GetGold(GetPCSpeaker()) < 1000)? TRUE: FALSE;
    return iResult;
}
