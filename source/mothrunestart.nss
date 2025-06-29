int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetSkillRank(SKILL_LORE, oPC) >= 5)) return FALSE;
return TRUE;
}

