#include "moth_inc_craftin"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
  if(GetSkillRank(SKILL_CRAFT_WEAPON,oPC,TRUE)>19&&
     IPGetIsMeleeWeapon(oItem)==TRUE)
    {
    return TRUE;
    }
    else
    {
    return FALSE;
    }
}
