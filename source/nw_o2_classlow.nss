//::///////////////////////////////////////////////
//:: General Treasure Spawn Script
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spawns in a RICH treasure.
    CR is capped at 5 (only low level items).
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   February 26 2001
//:: Modified By:  Syrsuro   July 2002
//:://////////////////////////////////////////////
#include "NW_O2_CONINCLUDE"
//#include "SYR_TG_INC_TABLE"

// NOT FOUND this whole script broken

void main()
{
/*   if (Syrsuro == TRUE)
    {
        int nTModifier = TREASURE_RICH;
        if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
        {
            return;
        }
        object oLastOpener = GetLastOpener();
        int nCR = FloatToInt(GetChallengeRating(OBJECT_SELF));/// Sets the CR = level of opener..
        if (nCR > 5) {nCR = 5;}
        TreasureChance(OBJECT_SELF, nCR, nTModifier);   /// The Treasure Generation Function (defined in sy_t_tcass)
        SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
        ShoutDisturbed();                   /// Should make local NPCs of the same faction as the chest hostile.
    }
    else
    {
        if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
        {
        return;
        }
        object oLastOpener = GetLastOpener();
        GenerateLowTreasure(oLastOpener, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
        ShoutDisturbed();
    }*/
}
