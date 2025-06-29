#include "x2_inc_itemprop"
void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (!GetIsObjectValid(oItem)) return;
    IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_VISUALEFFECT, -1);
}


