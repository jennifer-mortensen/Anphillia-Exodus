void main()
{
    int nAbility = ABILITY_WISDOM;
    int nLevel = GetLevelByClass(CLASS_TYPE_MONK);
    int nWis = GetAbilityModifier(nAbility)+1;
    effect eHeal = EffectHeal(nLevel*nWis);
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_G);
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_WHOLENESS_OF_BODY, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
}
