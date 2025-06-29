void main()
{
    int nSpellEffectID = 844;
    object oEffectCreator = GetAreaOfEffectCreator();
    object oTarget = GetEnteringObject();
    effect eResist = SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 10));

    if(oTarget != oEffectCreator && GetIsFriend(oTarget, oEffectCreator) && !GetHasSpellEffect(nSpellEffectID, oTarget))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eResist, oTarget);
    }
}
