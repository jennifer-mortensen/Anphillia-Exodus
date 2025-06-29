int StartingConditional()
{
    int iResult;

    iResult = (GetLocalString(OBJECT_SELF, "mothmuleowner") == GetName(GetPCSpeaker()))? TRUE: FALSE;
    return iResult;
}
