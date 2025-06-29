//::///////////////////////////////////////////////
//:: General Treasure Spawn Script     BOOK
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spawns in general purpose treasure, usable
    by all classes.
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   February 26 2001
//:: Modified By:  Syrsuro   July 2002
//:://////////////////////////////////////////////
#include "NW_O2_CONINCLUDE"
//#include "SYR_TG_INC_TABLE" NOT FOUND

//NOT FOUND this whole script is broken

void main()
{
/*   if (Syrsuro == TRUE)
    {
        struct Treasure Scroll;
        if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
        {
            return;
        }
            object oLastOpener = GetLastOpener();
            int nCR = FloatToInt(GetChallengeRating(OBJECT_SELF));
            nCR = nCR + (MagicLevel/2 - 3);  /// Sets the CR = level of opener..
            if (nCR < 1) {nCR = 1;}
           int nRandom = Random(30);
            if (nRandom < 27)
                {CreateItemOnObject(SyCreateBook(),OBJECT_SELF,1);}
            else if (nRandom < 28)
                {Scroll = SyCreateDivineScroll(nCR);}
            else if (nRandom < 30)
                {Scroll = SyCreateArcaneScroll(nCR);}
            CreateItemOnObject(Scroll.ItemOne,OBJECT_SELF,1);
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
        GenerateBookTreasure(oLastOpener, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
        ShoutDisturbed();
        }
*/
}
