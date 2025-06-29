void main()
{
    int nSpellEffectID = 845;
    object oEffectCreator = GetAreaOfEffectCreator();
    object oTarget = GetEnteringObject();
    int nImmunityDecrease = GetLocalInt(oEffectCreator, "IMMUNITY_DECREASE");
    effect eImmunityDecrease = SupernaturalEffect(EffectDamageImmunityDecrease(DAMAGE_TYPE_NEGATIVE, nImmunityDecrease));
    effect eVFX = EffectVisualEffect(VFX_DUR_GLOW_RED);
    effect eLink = EffectLinkEffects(eImmunityDecrease, eVFX);

    if(GetIsEnemy(oTarget, oEffectCreator) && !GetHasSpellEffect(nSpellEffectID, oTarget))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
    }
}
