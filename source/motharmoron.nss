
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oCloak = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    if (!GetIsObjectValid(oCloak) || GetPlotFlag(oCloak))
        return FALSE;
    else return TRUE;
}
