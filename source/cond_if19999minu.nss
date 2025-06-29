int StartingConditional()
{
    int iResult;

    iResult = (GetGold(GetPCSpeaker()) < 20000)? TRUE: FALSE;
    return iResult;
}
