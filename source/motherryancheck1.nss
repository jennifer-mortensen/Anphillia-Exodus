int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(!(GetLocalInt(oPC, "MothGotErryn1") == 1))
        return FALSE;

    return TRUE;
}
