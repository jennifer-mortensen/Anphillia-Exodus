int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetLocalObject(oPC, "oToolTarget");
    if (oTarget == OBJECT_INVALID) return FALSE;

    int nDisarmDiff = 10 + GetSkillRank(SKILL_DISABLE_TRAP, oPC) -
        (GetTrapDisarmDC(oTarget) - 100);

    if (nDisarmDiff <= -5) return TRUE;

    return FALSE;
}
