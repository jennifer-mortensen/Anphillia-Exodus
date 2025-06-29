void main()
{
    effect eAOE = EffectAreaOfEffect(AOE_MOB_UNNATURAL);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, HoursToSeconds(100));
}
