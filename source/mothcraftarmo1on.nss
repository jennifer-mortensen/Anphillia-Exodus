#include "moth_inc_craftin"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
  if(GetSkillRank(SKILL_CRAFT_ARMOR,oPC,TRUE)>24&&
     MothGetIsClothing(oItem)==FALSE)
    {
    return TRUE;
    }
    else
    {
    return FALSE;
    }
}
