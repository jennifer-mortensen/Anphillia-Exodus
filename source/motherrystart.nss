#include "nw_i0_tool"
int StartingConditional()
{
    if(!HasItem(GetPCSpeaker(), "motherrynbook"))
        return FALSE;
    object oItem;
    object oPC = GetPCSpeaker();
    oItem = GetItemPossessedBy(oPC, "motherrynbook");

    if (GetIsObjectValid(oItem))
        DestroyObject(oItem);
    return TRUE;
}
