int StartingConditional()
{
    int iResult;

    iResult = (GetGold(GetPCSpeaker()) < 250)? TRUE: FALSE;
    return iResult;
}
