#include "zep_inc_phenos2"
#include "x2_inc_switches"
void main()
{
object oPC;
object oItem;
int nEvent =GetUserDefinedItemEventNumber();
if (nEvent == X2_ITEM_EVENT_EQUIP)
{
oPC = GetPCItemLastEquippedBy();
zep_Fly(oPC,nCEP_WG_DRAGON_RED);
}
if (nEvent ==X2_ITEM_EVENT_UNEQUIP)
{
oPC = GetPCItemLastUnequippedBy();
zep_Fly_Land(oPC, TRUE);
}
}
