void main()
{
    effect eAOE = EffectAreaOfEffect(AOE_MOB_FEAR);
    int nDuration =10;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, HoursToSeconds(nDuration));
}
