int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetSkillRank(SKILL_LORE, oPC) >= 30)) return FALSE;
return TRUE;
}

