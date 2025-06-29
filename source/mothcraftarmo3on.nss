#include "moth_inc_craftin"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
  if(GetSkillRank(SKILL_CRAFT_ARMOR,oPC,TRUE)>34&&
     MatchShield(oItem)==TRUE)
    {
    return TRUE;
    }
    else
    {
    return FALSE;
    }
}
