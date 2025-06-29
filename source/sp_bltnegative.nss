#include "NW_I0_SPELLS"
void main()
{
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eBolt;
    int nCount = nHD /2;
    if (nCount == 0)
    {
        nCount = 1;
    }

    int nDamage = d6(nCount);
    if(GetAppearanceType(OBJECT_SELF) == 378 && GetIsPC(OBJECT_SELF)) //J. Persinne; PC wyrmling bolts need to be toned down slightly.
        nDamage -= 20;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    int nTouch = TouchAttackRanged(oTarget);
    if(nTouch > 0)
    {
        if(nTouch == 2)
        {
            nDamage *= 2;
        }
        eBolt = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
        if(nDamage > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBolt, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}
