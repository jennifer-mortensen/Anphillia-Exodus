//J. Persinne; this ability works differently on Anphillia Genesis.  The caster is granted 25% immunity to all physical damage types for 10 rounds.

void main()
{
    int nDuration = 10;
    effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eBludgResist = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 25);
    effect ePierceResist = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 25);
    effect eSlashResist = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 25);
    effect eImpact = EffectVisualEffect(VFX_IMP_AC_BONUS);

    effect eLink = EffectLinkEffects(eVis, eDur);
    eLink = EffectLinkEffects(eLink, eBludgResist);
    eLink = EffectLinkEffects(eLink, ePierceResist);
    eLink = EffectLinkEffects(eLink, eSlashResist);

    //Apply the VFX impact and effects
    if (!GetHasSpellEffect(GetSpellId(),OBJECT_SELF))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
}

