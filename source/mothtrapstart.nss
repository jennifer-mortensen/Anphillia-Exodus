int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetSkillRank(SKILL_CRAFT_TRAP,oPC)<10)
    {
    return FALSE;
    }
    return TRUE;
}
