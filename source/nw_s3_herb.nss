void main()
{
    int nID = GetSpellId();
    // * Belladonna
    if (nID == 409)
    {
       object oTarget = GetSpellTargetObject();
       effect eVisual = EffectVisualEffect(VFX_IMP_AC_BONUS);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVisual, oTarget);
       effect eACBonus = VersusRacialTypeEffect(EffectACIncrease(6), RACIAL_TYPE_ELEMENTAL);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eACBonus, oTarget, 180.0);

    }
    else
    // * Garlic; protection against Vampires
    if (nID == 410)
    {
       object oTarget = GetSpellTargetObject();
       effect eAttackBonus = VersusRacialTypeEffect(EffectAttackIncrease(3), RACIAL_TYPE_UNDEAD);
       effect eVisual = EffectVisualEffect(VFX_IMP_HOLY_AID);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVisual, oTarget);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackBonus, oTarget, 180.0);
    }

}
