int StartingConditional()
{
    int nPassed = 0;
    object oPC = GetPCSpeaker();
    if(GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, oPC) >= 10 ||
       GetLevelByClass(CLASS_TYPE_PALADIN, oPC) >= 5
    )
    {
      if(GetSkillRank(SKILL_RIDE,oPC)>=1 &&
         GetHasFeat(FEAT_PALADIN_SUMMON_MOUNT,oPC)==FALSE
      )
      {
       nPassed = 1;
      }
    }
    if(nPassed == 0)
        return FALSE;
    return TRUE;
}
