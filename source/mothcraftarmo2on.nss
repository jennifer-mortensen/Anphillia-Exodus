int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
  if(GetSkillRank(SKILL_CRAFT_ARMOR,oPC,TRUE)>29&&
     GetIsObjectValid(oItem)==TRUE)
    {
    return TRUE;
    }
    else
    {
    return FALSE;
    }
}
