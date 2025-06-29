void main()
{
    int nSpellEffectID = 842;
    object oEffectCreator = GetAreaOfEffectCreator();
    object oTarget = GetEnteringObject();
    effect eResist = SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 10));

    if(oTarget != oEffectCreator && GetIsFriend(oTarget, oEffectCreator) && !GetHasSpellEffect(nSpellEffectID, oTarget))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eResist, oTarget);
    }
}
