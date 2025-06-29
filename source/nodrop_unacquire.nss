#include "nodrop_include"
/*
By: mad_andrew

OnUnAcquire script for no-drop items.
Also requires an include "nodrop_include",
and a OnAcquire script "nodrop_acquire",
to work.
*/
void main()
{
//
object oItem = GetModuleItemLost();
object oPC = GetModuleItemLostBy();
object oInvItem = GetFirstItemInInventory(oItem);
/*
This checks if the item dropped is a container (like a box or bag),
and the box or bag is not ITSELF a no-drop item,
then does the same as below to all items within.
*/
if(GetIsNoDrop(oItem) == FALSE && GetIsObjectValid(oInvItem) == TRUE && (GetArea(oItem) != OBJECT_INVALID || GetItemPossessor(oItem) != OBJECT_INVALID))
{
    while(GetIsObjectValid(oInvItem) == TRUE)
    {
        if(GetIsNoDrop(oInvItem))
        {
            DestroyObject(oInvItem);
            CopyObject(oInvItem, GetLocation(oPC), oPC, GetTag(oInvItem));
        }
        oInvItem = GetNextItemInInventory(oItem);
    }
}
/*
This checks if the item dropped is "no-drop",,,

,,,and in an area,,,

,,or has a possessor thats not a creature (crate, chest, etc),,,

,,,destroys item and copies back to your inventory.
*/
else if(GetArea(oItem) != OBJECT_INVALID || (GetObjectType(GetItemPossessor(oItem)) != OBJECT_TYPE_CREATURE && GetItemPossessor(oItem) != OBJECT_INVALID))
{
    if(GetIsNoDrop(oItem) == TRUE)
    {
        DestroyObject(oItem);
        CopyObject(oItem, GetLocation(oPC), oPC, GetTag(oItem));
    }
}
//
}
