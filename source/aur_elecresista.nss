void main()
{
    int nSpellEffectID = 843;
    object oEffectCreator = GetAreaOfEffectCreator();
    object oTarget = GetEnteringObject();
    effect eResist = SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 10));

    if(oTarget != oEffectCreator && GetIsFriend(oTarget, oEffectCreator) && !GetHasSpellEffect(nSpellEffectID, oTarget))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eResist, oTarget);
    }
}
