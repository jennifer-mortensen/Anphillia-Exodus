#include "_inc_items"

void main()
{
    int i;
    object oPC = OBJECT_SELF;

    ClearImmunityApplicationFlags(oPC);
    for(i = 0; i < NUM_INVENTORY_SLOTS; i++)
    {
        HandleItemDamageImmunities(oPC, GetItemInSlot(i, oPC), TRUE, FALSE);
    }
    ApplyDamageImmunities(oPC);
}

