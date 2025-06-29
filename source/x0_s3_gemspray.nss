//mothonhitflame.nss
void main()
{
    object oTarget = GetSpellTargetObject();
    int nDamage;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eDam;
    nDamage = d4(1);
    eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}

