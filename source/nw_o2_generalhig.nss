//::///////////////////////////////////////////////
//:: General Treasure Spawn Script   HIGH
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This will spawn in a Standard Treasure.
    This treasure is not capped (up to high level items)
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
/*    if (Syrsuro == TRUE)
    {
        int nTModifier = TREASURE_STANDARD;
        if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
        {
            return;
        }
        object oLastOpener = GetLastOpener();
        int nCR = FloatToInt(GetChallengeRating(OBJECT_SELF));/// Sets the CR = level of opener..
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
        GenerateHighTreasure(oLastOpener, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
        ShoutDisturbed();
    }
*/
}
