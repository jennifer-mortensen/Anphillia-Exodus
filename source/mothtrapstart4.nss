int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetSkillRank(SKILL_CRAFT_TRAP,oPC)<24)
    {
    return FALSE;
    }
    return TRUE;
}
