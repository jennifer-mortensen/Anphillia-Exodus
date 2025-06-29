
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oGlove = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    string sTag = GetTag(oGlove);
    if (!GetIsObjectValid(oGlove) || GetPlotFlag(oGlove))
        return FALSE;
    else return TRUE;
}
