void main()
{
    object oPC = GetPCSpeaker();
    object oBattleHorn = GetItemPossessedBy(oPC, "MothBattleHorn");
    int nSummonMode = GetLocalInt(oBattleHorn, "SUMMON_MODE");
    if(nSummonMode == 1)
    {
        SetLocalInt(oBattleHorn, "SUMMON_MODE", 2);
    }
    else if(nSummonMode == 2)
    {
        SetLocalInt(oBattleHorn, "SUMMON_MODE", 1);
    }
    else
    {
        if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
        {
            SetLocalInt(oBattleHorn, "SUMMON_MODE", 2);
        }
        else
        {
            SetLocalInt(oBattleHorn, "SUMMON_MODE", 1);
        }
    }
}
