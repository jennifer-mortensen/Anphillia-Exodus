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
//#include "SYR_TG_INC_TABLE"

// NOT FOUND this whole script broken

void main()
{
/*   if (Syrsuro == TRUE)
    {
        struct Treasure Scroll;
        string sItem; object Item;
        if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
        {
            return;
        }
            object oLastOpener = GetLastOpener();
            int nCR = FloatToInt(GetChallengeRating(OBJECT_SELF));
            nCR = nCR + (MagicLevel/2 - 3);  /// Sets the CR = level of opener..
            int nTClass = nCR/4;
                if (nTClass > 4) {nTClass = 5;}
                if (nTClass < 0) {nTClass = 0;}
            int nRandom = Random(100);
            if (nRandom < 90)
                {}
            else if (nRandom < 94)
                {CreateItemOnObject(SyCreateAmmo(nTClass),OBJECT_SELF,d10(3));}
            else if (nRandom < 96)
                {CreateItemOnObject(SyCreateMeleeWeapon(nTClass),OBJECT_SELF,1);}
            else if (nRandom < 97)
                {CreateItemOnObject(SyCreateRangeWeapon(nTClass),OBJECT_SELF,1);}
            else if (nRandom < 100)
                {CreateItemOnObject(SyCreateThrown(nTClass),OBJECT_SELF,d10(3));}
        int nRND = d8();
        switch (nRND)
            {
            case 1: sItem =SyCreateWeapon(0);
                Item = CreateItemOnObject(sItem,OBJECT_SELF,1);
                if (IsArrows(Item))
                    {CreateItemOnObject(sItem,OBJECT_SELF,d10(3));}
            case 2: CreateItemOnObject(SyCreateThrown(0),OBJECT_SELF,d10(3));
            case 3: CreateItemOnObject(SyCreateAmmo(0),OBJECT_SELF,d10(3));
            case 4: CreateItemOnObject(SyCreateAmmo(0),OBJECT_SELF,d10(3));
            case 5: sItem =SyCreateWeapon(0);
                Item = CreateItemOnObject(sItem,OBJECT_SELF,1);
                if (IsArrows(Item))
                    {CreateItemOnObject(sItem,OBJECT_SELF,d10(3));}
            break;
            }
            SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
            ShoutDisturbed();                   /// Should make local NPCs of the same faction as the chest hostile.
    }
    else
        {
            return;
        }
*/
}
