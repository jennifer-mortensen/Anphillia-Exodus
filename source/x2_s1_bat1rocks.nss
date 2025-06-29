void RockDamage2(location lImpact, object oWeapon);
#include "x0_i0_spells"
void main()
{
    effect eImpacta = EffectVisualEffect(353);
    effect eImpactb = EffectVisualEffect(354);
    effect eImpact = EffectLinkEffects(eImpacta,eImpactb);
    effect eImpac1a = EffectVisualEffect(460);
    effect eImpac1b = EffectVisualEffect(VFX_IMP_PULSE_WIND);
    effect eImpac1 = EffectLinkEffects(eImpac1a,eImpac1b);
    location lImpact = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lImpact);
    DelayCommand(0.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpac1, lImpact));
    RockDamage2(lImpact,OBJECT_SELF);
}

void RockDamage2(location lImpact, object oWeapon)
{
    int nDice = 11;
    int nBonus = 33;
    int nDamagePower = DAMAGE_POWER_PLUS_FOUR;
    int nDC = 31;
    if(GetTag(oWeapon) == "cleaventrebuchet" || GetTag(oWeapon) == "axfelltrebuchet")
    {
        nDice = 22;
        nBonus = 44;
        nDamagePower = DAMAGE_POWER_PLUS_FIVE;
        nDC = 40;
    }
    float fDelay;
    int nDamage;
    effect eDam;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lImpact, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
            SignalEvent(oTarget, EventSpellCastAt(oWeapon, 773));
            fDelay = GetDistanceBetweenLocations(lImpact, GetLocation(oTarget))/20;
            nDamage = d6(nDice)+nBonus;
            if (MySavingThrow(SAVING_THROW_REFLEX,oTarget,nDC,SAVING_THROW_TYPE_TRAP,oWeapon,fDelay) >0)
                {
                 nDamage /=2;
                }
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING,nDamagePower);
            if(nDamage > 0)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lImpact, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

