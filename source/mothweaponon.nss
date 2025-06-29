
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oCloak = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    string sTag = GetTag(oCloak);
    if (!GetIsObjectValid(oCloak) || GetPlotFlag(oCloak))
        return FALSE;
    else return TRUE;
}
