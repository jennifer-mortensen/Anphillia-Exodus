#include "SYR_TG_SWITCHES"
#include "syr_tg_inc_magic"
#include "moth_inc"
#include "_inc_time"
int StartingConditional() { return FALSE; }
int GetMajorClass(object oCritter);
object CreateBag();
string CreateRandomObject (int nTClass, int nCR)
{
    string sNewItem;
    int nType = d8 ();
    switch (nType)
    {
        case 1:
            sNewItem = SyCreateArcaneScroll (nCR);
            break;
        case 2:
            sNewItem = SyCreateDivineScroll (nCR);
            break;
        case 3:
            sNewItem = SyCreatePotion (nTClass);
            break;
        case 4:
            sNewItem = SyCreateRing (nTClass);
            break;
        case 5:
            sNewItem = SyCreateAmulet (nTClass);
            break;
        case 6:
            sNewItem = SyCreateMisc (nTClass);
            break;
        case 7:
            sNewItem = SyCreateWand (nTClass);
            break;
        case 8:
            sNewItem = SyCreateGarb (nTClass);
            break;
    }
    return (sNewItem);
}
string CreateRandomObjectNoScrolls (int nTClass, int nCR)
{
    string sNewItem;
    int nType = d6 ();

    switch (nType)
    {
        case 1:
            sNewItem = SyCreatePotion (nTClass);
            break;
        case 2:
            sNewItem = SyCreateRing (nTClass);
            break;
        case 3:
            sNewItem = SyCreateAmulet (nTClass);
            break;
        case 4:
            sNewItem = SyCreateMisc (nTClass);
            break;
        case 5:
            sNewItem = SyCreateWand (nTClass);
            break;
        case 6:
            sNewItem = SyCreateGarb (nTClass);
            break;
    }
    return (sNewItem);
}
void SetIdentifyFlag (object oItem)
{
    int iGoldValue = GetGoldPieceValue(oItem);
    if (iGoldValue<200)
    {
        SetIdentified (oItem, TRUE);
    }
    else
    {
        int iValue;
        iValue = d100();
        if (iValue < 20)
        {
            SetIdentified (oItem, TRUE);
        }
        else
        {
            SetIdentified (oItem, FALSE);
        }
        if(GetBaseItemType(oItem)==BASE_ITEM_GEM ||
           GetBaseItemType(oItem)==BASE_ITEM_POTIONS ||
           GetBaseItemType(oItem)==BASE_ITEM_GOLD)
        {
            SetIdentified (oItem, TRUE);
        }
        if(GetBaseItemType(oItem)==BASE_ITEM_ARROW ||
           GetBaseItemType(oItem)==BASE_ITEM_SHURIKEN ||
           GetBaseItemType(oItem)==BASE_ITEM_BULLET ||
           GetBaseItemType(oItem)==BASE_ITEM_THROWINGAXE ||
           GetBaseItemType(oItem)==BASE_ITEM_BOLT ||
           GetBaseItemType(oItem)==BASE_ITEM_DART ||
           GetBaseItemType(oItem)==BASE_ITEM_SCROLL)
        {
            SetIdentified (oItem, TRUE);
            if (iValue > 66)
            {
             DelayCommand(0.5,SetIdentified (oItem, FALSE));
            }
        }
    }
}
void MaybeMakeItem (string sRef, object oTarget, int nStack)
{
    int nMakeIt = FALSE;
    float nCR = GetChallengeRating (oTarget);
    if (nCR > 0.0)
    {
        if (Random (100) < ((FloatToInt (nCR) * 2) + 10) + MagicLevel)
            nMakeIt = TRUE;

    } else
    {
        nMakeIt = TRUE;
    }

    if (nMakeIt)
    {
        object oCreated = CreateItemOnObject (sRef, oTarget, nStack);
        SetDroppableFlag(oCreated, TRUE);
    }
}
void GenerateNPCTreasure ()
{
    object oParentSpawn = GetLocalObject(OBJECT_SELF, "ParentSpawn");
    int nSpawnDelay;
    int nTimePassed;
    int nLastTreasureSpawn;
    int nSecondsSinceServerBoot;
    int nNoTreasureSpawn;

    if(GetIsObjectValid(oParentSpawn))
    {
        int nTreasureSetting = GetLocalInt(oParentSpawn, "RECENT_TREASURE_SETTING");
        if(nTreasureSetting == 1)
        {
            nNoTreasureSpawn = TRUE;
        }
        else if(nTreasureSetting == 2)
        {
            nNoTreasureSpawn = FALSE;
        }
        else
        {
            nSecondsSinceServerBoot = GetSecondsSinceServerBoot();
            nLastTreasureSpawn = GetLocalInt(oParentSpawn, "LAST_TREASURE_SPAWN");
            nTimePassed = nSecondsSinceServerBoot - nLastTreasureSpawn;
            nSpawnDelay = GetLocalInt(oParentSpawn, "f_SpawnDelay");
            if(nTimePassed < nSpawnDelay && nLastTreasureSpawn != 0)
            {
                nNoTreasureSpawn = TRUE;
                SetLocalInt(oParentSpawn, "RECENT_TREASURE_SETTING", 1);
                DelayCommand(1.1, DeleteLocalInt(oParentSpawn, "RECENT_TREASURE_SETTING"));
            }
            else
            {
                nNoTreasureSpawn = FALSE;
                DelayCommand(1.0, SetLocalInt(oParentSpawn, "LAST_TREASURE_SPAWN", nSecondsSinceServerBoot));
                SetLocalInt(oParentSpawn, "RECENT_TREASURE_SETTING", 2);
                DelayCommand(1.1, DeleteLocalInt(oParentSpawn, "RECENT_TREASURE_SETTING"));
            }
        }
    }

    object oMonster = OBJECT_SELF;
    if(GetRacialType(oMonster)!=RACIAL_TYPE_ANIMAL &&
       GetRacialType(oMonster)!=RACIAL_TYPE_VERMIN &&
       GetRacialType(oMonster)!=RACIAL_TYPE_ELEMENTAL &&
       GetRacialType(oMonster)!=RACIAL_TYPE_MAGICAL_BEAST
    )
    {
    int TREASURE_STANDARD = CashLevel;
    int TREASURE_RICH = CashLevel * 4;
    int TREASURE_POOR = CashLevel / 4;
    int nTClass;
    int nRan;
    int nGen = d4 ();
    int i;
    int nCR = FloatToInt (GetChallengeRating (oMonster));
    if (nCR < 10) {
        nTClass = 0;
       if (d100 () < MagicLevel)
            nTClass = 1;
    } else if (nCR < 20) {
        if (d100 () < MagicLevel)
            nTClass = 1;
        else if (Random (15) == 10)
            nTClass = 1;
        else
            nTClass = 0;

    } else if (nCR > 30) {
        nTClass = 2;
    } else {
        if (d100 () < MagicLevel)
            nTClass = 2;
        else if (d8 () == 1)
            nTClass = 2;
        else
            nTClass = 1;
    }
    object oSafe;
    object oItem;
    object oBag;

    if(nNoTreasureSpawn == TRUE || GetIsOpen(GetNearestObjectByTag("SYR_NPC_VIC",OBJECT_SELF,1)))
    {
        oSafe = OBJECT_INVALID;
        oBag = OBJECT_INVALID;
    }
    else
    {
        oBag = CreateBag();
        SetDroppableFlag(oBag, TRUE);
        SetLocked(oBag, TRUE);
        if(GetIsObjectValid(oBag))
            oSafe = oBag;
        else
            oSafe = OBJECT_INVALID;
    }

    int nMajorClass = GetMajorClass (oMonster);
    oMonster = OBJECT_INVALID; //J. Persinne; we no longer want to spawn treasure on NPCs themselves.
    switch(nMajorClass)
    {
        case CLASS_TYPE_FIGHTER   : /* =  4;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateShield (nTClass), oMonster, 1);
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
        case CLASS_TYPE_WEAPON_MASTER   : /* =  4;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateShield (nTClass), oMonster, 1);
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
        case CLASS_TYPE_PALADIN  : /* =  6;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
            if(oSafe != OBJECT_INVALID) oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (d3 () == 1)
            {
                oItem = CreateItemOnObject (SyCreateRangeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
                oItem = CreateItemOnObject (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
                SetDroppableFlag(oItem, TRUE);
                MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
            }
            MaybeMakeItem (SyCreatePotion (nTClass), oSafe, 1);
            break;
        case CLASS_TYPE_BLACKGUARD  : /* =  6;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (d3 () == 1)
            {
                oItem = CreateItemOnObject (SyCreateRangeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
                oItem = CreateItemOnObject (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
                SetDroppableFlag(oItem, TRUE);
                MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
            }
            MaybeMakeItem (SyCreatePotion (nTClass), oSafe, 1);
            break;
        case CLASS_TYPE_DIVINE_CHAMPION  : /* =  6;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (d3 () == 1)
            {
                oItem = CreateItemOnObject (SyCreateRangeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
                oItem = CreateItemOnObject (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
                SetDroppableFlag(oItem, TRUE);
                MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
            }
            MaybeMakeItem (SyCreatePotion (nTClass), oSafe, 1);
            break;
        case CLASS_TYPE_DWARVENDEFENDER  : /* =  6;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (d3 () == 1)
            {
                oItem = CreateItemOnObject (SyCreateRangeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
                oItem = CreateItemOnObject (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
                SetDroppableFlag(oItem, TRUE);
                MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
            }
            MaybeMakeItem (SyCreatePotion (nTClass), oSafe, 1);
            break;
        case CLASS_TYPE_PURPLE_DRAGON_KNIGHT  : /* =  6;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (d3 () == 1)
            {
                oItem = CreateItemOnObject (SyCreateRangeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
                oItem = CreateItemOnObject (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
                SetDroppableFlag(oItem, TRUE);
                MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
            }
            MaybeMakeItem (SyCreatePotion (nTClass), oSafe, 1);
            break;
        case CLASS_TYPE_CLERIC    : /* =  2;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    SetItemStackSize(oItem,99);
                CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateLightArmor (nTClass), oMonster, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (SyCreatePotion (nTClass), oSafe, 1);
            for (i = 0; i < nGen; i++)
                MaybeMakeItem (SyCreateDivineScroll (nCR), oMonster, 1);
            break;

        case CLASS_TYPE_BARD      : /* =  1;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateShield (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                    SetItemStackSize(oItem,99);
                CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }

            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateAmmo (nTClass), oSafe, 99);
            SetItemStackSize(oItem,99);
        case CLASS_TYPE_HARPER      : /* =  1;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateShield (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                    SetItemStackSize(oItem,99);
                CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }

            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateAmmo (nTClass), oSafe, 99);
            SetItemStackSize(oItem,99);
        case CLASS_TYPE_ARCANE_ARCHER      : /* =  1;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateShield (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                    SetItemStackSize(oItem,99);
                CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }

            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateAmmo (nTClass), oSafe, 99);
            SetItemStackSize(oItem,99);
        case CLASS_TYPE_BARBARIAN : /*=  0;*/
            if (nCR > 3)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateMediumArmor (nTClass), oMonster, 1);
                MaybeMakeItem (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            break;

        case CLASS_TYPE_DRUID     : /* =  3;*/
            if (d2 () == 1)
            oItem = CreateItemOnObject (SyCreateThrown (nTClass), oMonster, 50);
            MaybeMakeItem (SyCreateLightArmor (nTClass), oMonster, 1);
            oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateDivineScroll (nCR), oSafe, 1);
            MaybeMakeItem (SyCreatePotion (nTClass), oSafe, 1);
            MaybeMakeItem (SyCreateGem (nCR, TREASURE_STANDARD), oSafe, 1);
            break;
        case CLASS_TYPE_SHIFTER     : /* =  3;*/
            if (d2 () == 1)
            oItem = CreateItemOnObject (SyCreateThrown (nTClass), oMonster, 50);
            MaybeMakeItem (SyCreateLightArmor (nTClass), oMonster, 1);
            oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateDivineScroll (nCR), oSafe, 1);
            MaybeMakeItem (SyCreatePotion (nTClass), oSafe, 1);
            MaybeMakeItem (SyCreateGem (nCR, TREASURE_STANDARD), oSafe, 1);
            break;
        case CLASS_TYPE_ROGUE     : /* =  8;*/
            oItem = CreateItemOnObject (SyCreateThrown (nTClass), oMonster, 50);
            SetDroppableFlag(oItem, TRUE);
            oItem = CreateItemOnObject (SyCreateThrown (nTClass), oMonster, 50);
            SetDroppableFlag(oItem, TRUE);
            if (d4 () == 1)
                MaybeMakeItem (SyCreateTrapKit (nTClass), oSafe, 1);
                MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
        case CLASS_TYPE_SHADOWDANCER     : /* =  8;*/
            oItem = CreateItemOnObject (SyCreateThrown (nTClass), oMonster, 50);
            SetDroppableFlag(oItem, TRUE);
            oItem = CreateItemOnObject (SyCreateThrown (nTClass), oMonster, 50);
            SetDroppableFlag(oItem, TRUE);
            if (d4 () == 1)
                MaybeMakeItem (SyCreateTrapKit (nTClass), oSafe, 1);
                MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
        case CLASS_TYPE_ASSASSIN     : /* =  8;*/
            oItem = CreateItemOnObject (SyCreateThrown (nTClass), oMonster, 50);
            SetDroppableFlag(oItem, TRUE);
            oItem = CreateItemOnObject (SyCreateThrown (nTClass), oMonster, 50);
            SetDroppableFlag(oItem, TRUE);
            if (d4 () == 1)
                MaybeMakeItem (SyCreateTrapKit (nTClass), oSafe, 1);
                MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
        case CLASS_TYPE_RANGER    : /* =  7;*/
            if (nCR > 3)
            {
                MaybeMakeItem (SyCreateLightArmor (nTClass), oMonster, 1);
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (d2 () == 1)
            {
                oItem = CreateItemOnObject (SyCreateRangeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
                oItem = CreateItemOnObject (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
                SetDroppableFlag(oItem, TRUE);
                MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                SetItemStackSize(oItem,99);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreatePotion (nTClass), oSafe, 1);
            break;

        case CLASS_TYPE_MONK      : /* =  5;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                    SetItemStackSize(oItem,99);
                CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateHands (nTClass), oMonster, 1);
            MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            break;

        case CLASS_TYPE_SORCERER  : /* =  9;*/
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            for (i = 0; i < nGen; i++)
                MaybeMakeItem (SyCreateArcaneScroll (nCR), oMonster, 1);
            MaybeMakeItem (SyCreateRobes (nTClass), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            break;
        case CLASS_TYPE_WIZARD    : /* =  10;*/
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            for (i = 0; i < nGen; i++)
                MaybeMakeItem (SyCreateArcaneScroll (nCR), oMonster, 1);
            MaybeMakeItem (SyCreateRobes (nTClass), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            break;
        case CLASS_TYPE_PALEMASTER    : /* =  10;*/
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            for (i = 0; i < nGen; i++)
                MaybeMakeItem (SyCreateArcaneScroll (nCR), oMonster, 1);
            MaybeMakeItem (SyCreateRobes (nTClass), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            break;
        case CLASS_TYPE_DRAGON    : /* =  18;*/
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            oItem = CreateItemOnObject (CreateRandomObjectNoScrolls (nTClass, nCR), oSafe, 1);
            SetDroppableFlag(oItem, TRUE);
            oItem = CreateItemOnObject (CreateRandomObjectNoScrolls (nTClass, nCR), oSafe, 1);
            SetDroppableFlag(oItem, TRUE);
            oItem = CreateItemOnObject (SyCreateRing (nTClass), oSafe, 1);
            SetDroppableFlag(oItem, TRUE);
            oItem = CreateItemOnObject (SyCreateAmulet (nTClass), oSafe, 1);
            SetDroppableFlag(oItem, TRUE);
            oItem = CreateItemOnObject (CreateRandomObjectNoScrolls (nTClass, nCR), oSafe, 1);
            SetDroppableFlag(oItem, TRUE);
            break;

        case CLASS_TYPE_ABERRATION : /* =  11;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateShield (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                    SetItemStackSize(oItem,99);
                CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateHands (nTClass), oMonster, 1);
            MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            break;
        case CLASS_TYPE_MONSTROUS : /* =  15;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateShield (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                    SetItemStackSize(oItem,99);
                CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateHands (nTClass), oMonster, 1);
            MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            break;
        case CLASS_TYPE_OUTSIDER  : /* =  24; */
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateShield (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                    SetItemStackSize(oItem,99);
                CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateHands (nTClass), oMonster, 1);
            MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            break;
        case CLASS_TYPE_GIANT     : /* =  22;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateShield (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                    SetItemStackSize(oItem,99);
                CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateHands (nTClass), oMonster, 1);
            MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            break;
        case CLASS_TYPE_FEY       : /* =  17;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateShield (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                    SetItemStackSize(oItem,99);
                CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateHands (nTClass), oMonster, 1);
            MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            break;
        case CLASS_TYPE_SHAPECHANGER : /* =  25;*/
            if (nCR > 4)
            {
                if (d4 () == 1)
                    MaybeMakeItem (SyCreateHelm (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateHeavyArmor (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateShield (nTClass), oMonster, 1);
                    MaybeMakeItem (SyCreateAmmo (nTClass), oMonster, 99);
                    SetItemStackSize(oItem,99);
                CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
            }
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_STANDARD));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateHands (nTClass), oMonster, 1);
            MaybeMakeItem (SyCreateRobes (nTClass), oMonster, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            break;
        case CLASS_TYPE_HUMANOID  : /* =  14;*/
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateGem (nCR, TREASURE_STANDARD), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (d4 () == 1)
                MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (nCR > 3)
            {
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
            break;

        case CLASS_TYPE_ANIMAL    : /* =  12;*/
        case CLASS_TYPE_CONSTRUCT : /* =  13;*/
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateGem (nCR, TREASURE_STANDARD), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (d4 () == 1)
                MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (nCR > 3)
            {
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
            break;
        case CLASS_TYPE_ELEMENTAL : /* =  16;*/
        case CLASS_TYPE_UNDEAD    : /* =  19;*/
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateGem (nCR, TREASURE_STANDARD), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (d4 () == 1)
                MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (nCR > 3)
            {
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
            break;
        case CLASS_TYPE_BEAST     : /* =  21;*/
        case CLASS_TYPE_MAGICAL_BEAST : /* =  23;*/
            oItem = CreateItemOnObject ("NW_IT_GOLD001", oSafe, SyCreateGold (nCR, TREASURE_POOR));
            SetDroppableFlag(oItem, TRUE);
            MaybeMakeItem (SyCreateGem (nCR, TREASURE_STANDARD), oSafe, 1);
            MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (d4 () == 1)
                MaybeMakeItem (CreateRandomObject (nTClass, nCR), oSafe, 1);
            if (nCR > 3)
            {
                oItem = CreateItemOnObject (SyCreateMeleeWeapon (nTClass), oMonster, 1);
                SetDroppableFlag(oItem, TRUE);
            }
            break;
        case CLASS_TYPE_VERMIN    : /* =  26; */
    }

    oItem = GetFirstItemInInventory (OBJECT_SELF);
    while (GetIsObjectValid (oItem))
    {
        SetIdentifyFlag (oItem);
        oItem = GetNextItemInInventory (OBJECT_SELF);
    }
    oItem = GetFirstItemInInventory (oBag);
    while (GetIsObjectValid (oItem))
    {
        SetIdentifyFlag (oItem);
        oItem = GetNextItemInInventory (oBag);
    }

    oItem = GetFirstItemInInventory (OBJECT_SELF);
    while (GetIsObjectValid (oItem))
    {
        SetIdentifyFlag (oItem);
        oItem = GetNextItemInInventory (OBJECT_SELF);
    }
    }
}
object CreateBag()
{
    location lWhere = GetLocation(OBJECT_SELF);
    object oBag = GetNearestObjectByTag("SYR_NPC_VIC",OBJECT_SELF,1);
    if ((GetIsObjectValid(oBag)) &
        (GetDistanceToObject(oBag) < 260.0f))
    {
        if (!GetLocked (oBag) && !GetIsOpen(oBag))
        {
            object oItem = GetFirstItemInInventory (oBag);
            while (GetIsObjectValid (oItem))
            {
                DestroyObject (oItem);
                oItem = GetNextItemInInventory (oBag);
            }
        }

        return oBag;
    }
    else if (CreateNPCBag == TRUE)
    {
        oBag = CreateObject(OBJECT_TYPE_PLACEABLE, "npcitemvirtualco",lWhere, FALSE);
        return oBag;
    }

    return OBJECT_INVALID;
}
int GetMajorClass(object oCritter)
{
    int nMajorClass = CLASS_TYPE_INVALID;
    int nLevOne = GetLevelByPosition(1,oCritter);
    int nLevTwo = GetLevelByPosition(2,oCritter);
    int nLevThr = GetLevelByPosition(3,oCritter);
    int nTotal = nLevOne + nLevTwo + nLevThr;
    if (nLevOne*2 >= nTotal) {nMajorClass = GetClassByPosition(1,oCritter);}
    else if (nLevTwo*2 >= nTotal) {nMajorClass = GetClassByPosition(2,oCritter);}
    else if (nLevThr*2 >= nTotal) {nMajorClass = GetClassByPosition(3,oCritter);}
    else
    {
        nMajorClass = GetClassByPosition(1,oCritter);
        if (GetClassByPosition(2,oCritter) >= nMajorClass)
            {nMajorClass = GetClassByPosition(2,oCritter);}
        if (GetClassByPosition(3,oCritter) >= nMajorClass)
            {nMajorClass = GetClassByPosition(3,oCritter);}
    }
    return nMajorClass;
}

