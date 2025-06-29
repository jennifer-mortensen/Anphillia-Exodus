int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oGlove = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    if (!GetIsObjectValid(oGlove)){return FALSE;}
    if(GetHasFeat(FEAT_EPIC_IMPROVED_KI_STRIKE_5,oPC)==FALSE){return FALSE;}
    if(GetItemHasItemProperty(oGlove,ITEM_PROPERTY_ATTACK_BONUS)==FALSE){return FALSE;}
    else return TRUE;

}
