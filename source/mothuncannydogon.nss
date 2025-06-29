int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetHasFeat(FEAT_UNCANNY_DODGE_3,oPC)==TRUE &&
   GetSkillRank(SKILL_BLUFF,oPC,TRUE)>15
)
{
return TRUE;
}
else
{
return FALSE;
}
}
