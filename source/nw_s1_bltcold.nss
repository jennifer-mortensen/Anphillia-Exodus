//::///////////////////////////////////////////////
//:: Bolt: Cold
//:: NW_S1_BltCold
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creature must make a ranged touch attack to hit
    the intended target.  Reflex or Will save is
    needed to halve damage or avoid effect.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 11 , 2001
//:: Updated On: July 15, 2003 Georg Zoeller - Removed saving throws
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "_inc_gen"
void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eBolt;
    int nCount = nHD /2;
    if (nCount == 0)
    {
        nCount = 1;
    }

    int nDamage = d6(nCount);
    if(GetIsPolymorphType(OBJECT_SELF, ANPH_POLYMORPH_TYPE_WYRMLING_WHITE_EPIC)) //J. Persinne; PC wyrmling bolts need to be toned down slightly.
        nDamage -= 20;
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_COLD));
    //Make a ranged touch attack
    int nTouch = TouchAttackRanged(oTarget);
    if(nTouch > 0)
    {
        if(nTouch == 2)
        {
            nDamage *= 2;
        }
        //Set damage effect
        eBolt = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
        if(nDamage > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBolt, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}
