int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetSkillRank(SKILL_LORE, oPC) <= 29)) return FALSE;
return TRUE;
}

