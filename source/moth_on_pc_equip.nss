#include "tk_hips_inc"
#include "x0_i0_spells"
#include "x2_inc_switches"
#include "x3_inc_horse"
#include "_inc_items"
#include "_inc_gen"

void main()
{

  object oPC = GetPCItemLastEquippedBy();
  object oItem = GetPCItemLastEquipped();
  string sTag = GetTag(oItem);
  //TK_HiPS_OnFeatChange(oPC); //J. Persinne, Feb. 11 2010; we have no equippable HiPS items on Exodus, so we'll just handle this with the rest of the shifter code below, to save on unnecessary process cycles.
  //int type = GetBaseItemType(GetPCItemLastEquipped());
  // Mounted benefits control
  if(GetWeaponRanged(oItem))
    {
        if(!GetLocalInt(oPC, "mothgenblocksummon"))
        {
        SetLocalInt(oPC,"bX3_M_ARCHERY",TRUE);
        HORSE_SupportAdjustMountedArcheryPenalty(oPC);
        }
    }

  if(!GetIsPolymorphed(oPC)) //J. Persinne, Feb. 11 2010; we'll no longer attempt to read DM notes or item immunities if the character is shifted.
  {
    if(GetLocalInt(oPC, "IMMUNITY_APPLICATION_FLAGS_CLEARED") == TRUE)
        HandleItemDamageImmunities(oPC, oItem, TRUE);
    HandleDMNoteRequirements(oPC, oItem);
  }
  else //The character is shifted; check for shifter-specific properties.
  {
    if(sTag == "SHF_DEATH_SLAAD_PROPERTIES") //Death slaad speed applies.
    {
        SetCreatureAppearanceType(oPC, 426);
    }
    else if(sTag == "SHF_EPIC_KOBOLD_COMM_PROPERTIES" || //HiPS applies.
            sTag == "SHF_KOBOLD_COMMANDO_PROPERTIES" ||
            sTag == "SHF_SPECTRE_PROPERTIES")
    {
        TK_HiPS_OnFeatChange(oPC);
    }
  }

  /*if(!( type == BASE_ITEM_ARROW || //J. Persinne, Feb. 11 2010; we'll no longer action cancel on weapon equip.
        type == BASE_ITEM_BULLET ||
        type == BASE_ITEM_ARMOR ||
        type ==  BASE_ITEM_BOOTS ||
        type == BASE_ITEM_BELT ||
        type == BASE_ITEM_HELMET ||
        type == BASE_ITEM_RING ||
        type ==  BASE_ITEM_AMULET ||
        type == BASE_ITEM_CLOAK ||
        type == BASE_ITEM_GLOVES ||
        type == BASE_ITEM_BOLT ||
        type == BASE_ITEM_BRACER ||
        GetHasEffect(EFFECT_TYPE_POLYMORPH,oPC)
    )){
        DelayCommand(0.4,AssignCommand(oPC, ClearAllActions()));
     }*/
}
