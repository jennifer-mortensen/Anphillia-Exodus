int StartingConditional()
{
    int iResult;

    iResult = (GetGold(GetPCSpeaker()) < 500)? TRUE: FALSE;
    return iResult;
}
