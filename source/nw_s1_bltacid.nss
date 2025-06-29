#include "NW_I0_SPELLS"
#include "_inc_gen"
void main()
{
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    effect eBolt;
    //int nDC = 10 + (nHD/2);
    int nCount = nHD /2;
    if (nCount == 0)
    {
        nCount = 1;
    }

    int nDamage = d6(nCount);
    if(GetIsPolymorphType(OBJECT_SELF, ANPH_POLYMORPH_TYPE_WYRMLING_GREEN_EPIC)) //J. Persinne; PC wyrmling bolts need to be toned down slightly.
        nDamage -= 20;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_ACID));
    int nTouch = TouchAttackRanged(oTarget);
    if(nTouch > 0)
    {
        if(nTouch == 2)
        {
            nDamage *= 2;
        }
        eBolt = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
        if(nDamage > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBolt, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}
