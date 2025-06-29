//::///////////////////////////////////////////////
//:: User Defined Henchmen Script
//:: NW_CH_ACD
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The most complicated script in the game.
    ... ever
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 18, 2002
//:://////////////////////////////////////////////
#include "X0_INC_HENAI"
#include "x2_inc_spellhook"

void JumpToWeakestEnemy2(object oTarget)
{
    object oTargetVictim = GetFactionMostDamagedMember(oTarget);
    // * won't jump if closer than 3 meters to victim
    if ((GetDistanceToObject(oTargetVictim) > 3.0)   && (GetObjectSeen(oTargetVictim) == TRUE))
    {
        ClearAllActions();
        effect eVis = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);

//        SpeakString("Jump to " + GetName(oTargetVictim));
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
        DelayCommand(0.3,ActionJumpToObject(oTargetVictim));
        DelayCommand(0.5,ActionAttack(oTargetVictim));
    }
}
void main()
{
    // * During Combat try teleporting around
    if (GetUserDefinedEventNumber() == 1003)
    {
        // * if random OR heavily wounded then teleport to next enemy
        if ((Random(100) < 50)  ||  ( (GetCurrentHitPoints() / GetMaxHitPoints()) * 100 < 50) )
        {
           JumpToWeakestEnemy2(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY));
        }
    }
}
