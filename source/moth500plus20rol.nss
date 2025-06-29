int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult = (GetGold(oPC) >= 500)? TRUE: FALSE;
    return iResult;
}
