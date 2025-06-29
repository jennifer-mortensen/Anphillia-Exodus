#include "x0_i0_treasure"
void main()
{
    object oPC = GetLastUsedBy();
    float fDelay = 3800.0;//Set respawn time in seconds
    if(GetLocalInt(OBJECT_SELF,"opened") != 1)
        {
        object oItem = GetFirstItemInInventory();
        while(GetIsObjectValid(oItem))
            {
            DestroyObject(oItem);
            oItem = GetNextItemInInventory();
            }
        CTG_CreateTreasure(TREASURE_TYPE_MED, GetLastOpener(), OBJECT_SELF);
        SetLocalInt(OBJECT_SELF,"opened",1);
        CTG_SetIsTreasureGenerated(OBJECT_SELF, FALSE);
        DelayCommand (fDelay,SetLocalInt(OBJECT_SELF,"opened",0));
        }
}

