#include "zep_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    object oHelmet = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    ZEP_StartCraft(oPC, oHelmet);

}
