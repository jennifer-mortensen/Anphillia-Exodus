int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetSkillRank(SKILL_CRAFT_TRAP,oPC)<14)
    {
    return FALSE;
    }
    return TRUE;
}
