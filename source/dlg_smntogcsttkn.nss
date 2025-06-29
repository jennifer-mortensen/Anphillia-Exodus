void main()
{
    object oPC = GetPCSpeaker();
    int nSummonMode = GetLocalInt(GetItemPossessedBy(oPC, "MothBattleHorn"), "SUMMON_MODE");
    if(nSummonMode == 1)
    {
        SetCustomToken(6000, "Good");
    }
    else if(nSummonMode == 2)
    {
        SetCustomToken(6000, "Evil");
    }
    else
    {
        if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
        {
            SetCustomToken(6000, "Good");
        }
        else
        {
            SetCustomToken(6000, "Evil");
        }
    }
}
