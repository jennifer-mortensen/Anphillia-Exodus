
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oCloak = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    if (!GetIsObjectValid(oCloak) || GetPlotFlag(oCloak))
        return FALSE;
    else return TRUE;
}
