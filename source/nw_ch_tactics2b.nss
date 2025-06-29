// * Is the PCSpeaker
// * the Henchman's master?

int StartingConditional()
{
    int iResult;
    iResult = GetMaster() != GetPCSpeaker();
    GetLocalInt(OBJECT_SELF,"Hired") == FALSE;
    return iResult;
}
