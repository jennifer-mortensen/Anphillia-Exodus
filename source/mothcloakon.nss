
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    if (!GetIsObjectValid(oCloak))
        return FALSE;
    else return TRUE;
}
