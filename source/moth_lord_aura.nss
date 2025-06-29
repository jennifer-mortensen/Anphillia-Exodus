void main()
{
    //Set and apply AOE object
    effect eAOE = EffectAreaOfEffect(AOE_MOB_FEAR,"moth_lord_auraa","","");
    int nDuration = GetSkillRank(SKILL_TAUNT,OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, HoursToSeconds(nDuration));
}
