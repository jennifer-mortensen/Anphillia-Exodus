#include "nodrop_include"
/*
By: mad_andrew

OnAcquire script for no-drop items.
Also requires an include "nodrop_include",
and a OnUnAcquire script "nodrop_unacquire",
to work.
*/
void main()
{
//
object oItem = GetModuleItemAcquired();
object oPrevOwner = GetModuleItemLostBy();//See "NOTE" at bottom
object oFinder = GetItemPossessor(oItem);
/*
If item dropped is a container (box or bag) and is not ITSELF nodrop, the
contents are cycled through.

If the previous owner is not the one getting it (previous owner is self if
picked off the ground),,,

,,,and if it's no-drop,,,

,,,and if the previous owner WAS a creature,,,

,,,destroy it and copy to the previous owners inventory.
*/
object oInvItem = GetFirstItemInInventory(oItem);
if(GetIsObjectValid(oInvItem) == TRUE && GetIsNoDrop(oItem) == FALSE)
{
    while(GetIsObjectValid(oInvItem) == TRUE)
    {
        if(oPrevOwner != oFinder)
        {
            if(GetIsNoDrop(oInvItem) && GetObjectType(oPrevOwner) == OBJECT_TYPE_CREATURE)
            {
                DestroyObject(oInvItem);
                CopyObject(oInvItem, GetLocation(oPrevOwner), oPrevOwner, GetTag(oItem));
            }
        }
        oInvItem = GetNextItemInInventory(oItem);
    }
}
/*
If item is NOT a container (box or bag as above) and previous owner was a
creature,,,

,,,and if previous owner is not self (as above),,,

,,destroy item and copy to previous owners inventory,,,

,,plus if the modbuilder forgot to set as plot to avoid selling, this sets as
plot now.
*/
else if(GetIsNoDrop(oItem) == TRUE && GetObjectType(oPrevOwner) == OBJECT_TYPE_CREATURE)
{
    if(oPrevOwner != oFinder)
    {
        DestroyObject(oItem);
        CopyObject(oItem, GetLocation(oPrevOwner), oPrevOwner, GetTag(oItem));
    }
    SetPlotFlag(oItem, TRUE);
}
/*
NOTE

GetModuleItemAcquiredFrom() is broken.

GetModuleItemLostBy() is used instead.

This new function only works on creatures correctly, so some strange workarounds
are present.

This was in v1.29
If in a later version GetModuleItemAcquiredFrom() suddenly starts working,
or the workaround ( GetModuleItemLostBy() ) ceases to work,
please contact me to change the script :D
*/
}

