//////////////////////////////////////////////////////////
/*
   Item Appearance Modification Conversation
   Finish Conversation Script
*/
// created/updated 2003-06-24 Georg Zoeller, Bioware Corp
//////////////////////////////////////////////////////////
#include "x2_inc_craft"
void main()
{
    object oPC = GetPCSpeaker();
    if (CIGetCurrentModMode(GetPCSpeaker()) != X2_CI_MODMODE_INVALID )
    {
        object oBackup = CIGetCurrentModBackup(oPC);

        int bSuccess = FALSE;
        if (CIGetCurrentModMode(oPC) == X2_CI_MODMODE_ARMOR)
        {
            //FloatingTextStrRefOnCreature(83449,oPC);
            bSuccess = TRUE;
            //FloatingTextStrRefOnCreature(83449,oPC);
        }

        object oNew = CIGetCurrentModItem(oPC);
        AssignCommand(oPC,ClearAllActions(TRUE));
        if (CIGetCurrentModMode(oPC) == X2_CI_MODMODE_ARMOR)
        {
             AssignCommand(oPC, ActionEquipItem(oNew,INVENTORY_SLOT_CHEST));
        }
        else if (CIGetCurrentModMode(oPC) == X2_CI_MODMODE_WEAPON)
        {
               AssignCommand(oPC, ActionEquipItem(oNew,INVENTORY_SLOT_RIGHTHAND));
        }
        //----------------------------------------------------------------------
        // This is to work around a problem with temporary item properties
        // sometimes staying around when they are on a cloned item.
        //----------------------------------------------------------------------
        IPRemoveAllItemProperties(oNew,DURATION_TYPE_TEMPORARY);
        CISetCurrentModMode(oPC,X2_CI_MODMODE_INVALID );

        // remove backup
        DestroyObject(oBackup);
    }
    else
    {
       ClearAllActions();
    }

    // Remove custscene immobilize from player
    effect eEff = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEff))
    {
         if (GetEffectType(eEff) == EFFECT_TYPE_CUTSCENEIMMOBILIZE
             && GetEffectCreator(eEff) == oPC
             && GetEffectSubType(eEff) == SUBTYPE_EXTRAORDINARY )
         {
            RemoveEffect(oPC,eEff);
         }
         eEff = GetNextEffect(oPC);
     }

    RestoreCameraFacing() ;

}
