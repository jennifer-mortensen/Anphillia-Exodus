#include "moth_inc_craftin"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
  if(!IPGetIsMeleeWeapon(oItem))
  {
  return FALSE;
  }
  if(!GetHasFeat(FEAT_MIGHTY_RAGE,oPC))
  {
  return FALSE;
  }
  if(GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)<26)
  {
  return FALSE;
  }
  else return TRUE;
}
