int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetSkillRank(SKILL_BLUFF, oPC) >= 25)) return FALSE;
if (!(GetSkillRank(SKILL_PERSUADE, oPC) >= 23)) return FALSE;
if (!(GetSkillRank(SKILL_TAUNT, oPC) >= 24)) return FALSE;
    object oItem;
    oItem = GetItemPossessedBy(oPC, "motherrynbook");
    if (GetIsObjectValid(oItem))
        DestroyObject(oItem);
return TRUE;
}
