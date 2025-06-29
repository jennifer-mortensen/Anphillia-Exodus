/****************************************************
  Orevein OnUsed Script
  ats_orevein_use

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is placed on an Orevein's
  OnUsed trigger.  It makes sure the player has
  the proper mining tool equipped and then causes
  the player to attack the orevein.
****************************************************/
#include "ats_inc_common"
#include "ats_const_common"
#include "ats_inc_skill_mn"
#include "moth_inc_craftin"
void main()
{
    object oPlayer = GetLastUsedBy();
    object oVein = OBJECT_SELF;
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);
    if(ATS_GetTagBaseType(oWeapon) == CSTR_MINETOOL)
    {
      if(GetLocalInt(oPlayer,"MOTHAUTOMINE"))
      {
          int iMaterialType = GetLocalInt(oVein, "ats_material_type");
          int iMiningResult = CalculateMiningSuccess(oPlayer, iMaterialType);
          DelayCommand(5.5,DeleteLocalInt(oPlayer,"MOTHOREREADY"));
          if(GetLocalInt(oPlayer,"MOTHOREREADY") == FALSE)
          {
           if(iMiningResult == CINT_UNSKILLED)
             {
              FloatingTextStringOnCreature("You are too unskilled to automine this vein!", oPlayer, FALSE);
              return;
             }
           else
             {
              MothAutoMining(oPlayer,oVein,oWeapon);
             }
          }
          else
          {
          FloatingTextStringOnCreature("This Vein is not ready to be mined!", oPlayer, FALSE);
          }
      }
      else
      {
       AssignCommand(oPlayer, DoPlaceableObjectAction(oVein,PLACEABLE_ACTION_BASH));
      }
    }
    else
    FloatingTextStringOnCreature(CSTR_ERROR1_MINING, oPlayer, FALSE);
}
