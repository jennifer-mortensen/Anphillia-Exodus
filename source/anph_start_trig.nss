#include "hc_inc"
#include "anph_persist_inc"
#include "anph_inc"
#include "_inc_items"

void main()
{
    object oPC = GetEnteringObject ();
    if (!GetIsPC(oPC)) return;
    object oTarget;
    object oMaster = GetMaster(oPC);
    if (GetIsObjectValid(oMaster))
       return;

    int nFaction = AnphGetPlayerTeamInt(oPC);

    //--------------------------------------------------------------------------
    // Delete stuff we dont want
    //--------------------------------------------------------------------------
    // delete player's rulebooks
    /*object oItem = GetItemPossessedBy(oPC,"Anp");
    if(GetIsObjectValid(oItem))
        DestroyObject(oItem);
    oItem = GetItemPossessedBy(oPC,"Anp");
    if(GetIsObjectValid(oItem))
        DestroyObject(oItem);*/
    //Destroy wands of AFK
    //oItem = GetItemPossessedBy(oPC, "Wan");
    //if(GetIsObjectValid(oItem))
     //   DestroyObject(oItem);

    //--------------------------------------------------------------------------
    // Update any missing items
    //--------------------------------------------------------------------------
    // Anphillia history.
    /*oItem = GetItemPossessedBy(oPC,"AnphilliaRuleBook");
    if(GetIsObjectValid(oItem)){
        DestroyObject(oItem);
        CreateItemOnObject("AnphilliaRuleBook_3FAC", oPC);
    }else{
        CreateItemOnObject("WandofAFK", oPC);
    }
    */
    // Give PC's an EmoteWand if using the DMHelper set.
    //oItem = GetItemPossessedBy(oPC,"EmoteWand");
    //if(!GetIsObjectValid(oItem))
        //CreateItemOnObject("emotewand", oPC);
    // Give PC's an EmoteWand if using the DMHelper set.
    //oItem = GetItemPossessedBy(oPC,"AnphilliaRuleBook");
    //if(!GetIsObjectValid(oItem))
     //   CreateItemOnObject("anphilliaruleboo", oPC);
        // Give PC's an EmoteWand if using the DMHelper set.
    //oItem = GetItemPossessedBy(oPC,"WandofAFK");
    //if(!GetIsObjectValid(oItem))
    //    CreateItemOnObject("wandofafk", oPC);

    // Give druids Ear of the Druid
   /* if(GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0 && !GetIsObjectValid(GetItemPossessedBy(oPC, "DruidEar")))
        CreateItemOnObject("DruidEar", oPC);

    // Give players the Wand of AFK
    //if(!GetIsObjectValid(GetItemPossessedBy(oPC,"AnphilliaRuleBook")))
    //    CreateItemOnObject("AnphilliaRuleBook_3FAC", oPC);
    // Give players the Wand of AFK
    //if(!GetIsObjectValid(GetItemPossessedBy(oPC,"WandofAFK")))
    //   CreateItemOnObject("wandofafk", oPC);

    //Ranger tracking tool
    if(GetLevelByClass(CLASS_TYPE_RANGER,oPC) && GetIsObjectValid(GetItemPossessedBy(oPC,"TrackerTool"))==FALSE)
        CreateItemOnObject("trackertool", oPC);  */

    /* Give Paladins their tools that simulate missing abilities
    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>1 && GetIsObjectValid(GetItemPossessedBy(oPC,"hc_palbadgecour"))==FALSE)
        CreateItemOnObject("paladinsbadgeofc", oPC);
    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) && GetIsObjectValid(GetItemPossessedBy(oPC,"hc_paladinsymb"))==FALSE)
        CreateItemOnObject("paladinsholysymb", oPC);   */

    // Give PC's a Trap Tool in inventory
//    if(GetLocalInt(oMod,"HCRTRAPS") && GetIsObjectValid(GetItemPossessedBy
//        (oPC,"searchtool"))==FALSE)
//           CreateItemOnObject("searchtool", oPC);

    // Give PC's the ball of saving.
//    if(!GetIsObjectValid(GetItemPossessedBy(oPC,"ballofsaving")))
//         CreateItemOnObject("ballofsaving", oPC);

    // Check for tensers sword.
    //oItem = GetItemPossessedBy (oPC, "NW_WSWMLS013");
    //if (GetIsObjectValid (oItem)){
    //    SendMessageToPC (oPC, "Tenser's sword crumbles to dust..");
    //    DestroyObject (oItem);
    //}

    object oItem = GetItemPossessedBy(oPC, "mothtelebugbear"); //J. Persinne; we do not allow PCs to keep the bugbear teleporter after reboot.
    if(GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
    }

    //--------------------------------------------------------------------------
    // This part converts old players to the new configurable anph system
    //--------------------------------------------------------------------------
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "CleavenMilitiaRing")))
    {
       RecreateFactionItems(oPC, 1);
       nFaction = 1;
    }
    else if (GetIsObjectValid(GetItemPossessedBy(oPC, "AxfellWarriorRing")))
    {
       RecreateFactionItems(oPC, 2);
       nFaction = 2;
    }
    /*else if (GetIsObjectValid(GetItemPossessedBy(oPC, "RanzingtonCitizenRing")))
    {
       RecreateFactionItems(oPC, 3);
       nFaction = 3;
    }
    else if (GetIsObjectValid(GetItemPossessedBy(oPC, "DrowRing")))
    {
       RecreateFactionItems(oPC, 4);
       nFaction = 4;
    } */
    /* All Items should be set now */

    if (GetXP (oPC) <= 1)
    {
        if (nFaction == 0)
        {
            oTarget = GetObjectByTag("ChooseSideLocation");
            AssignCommand(oPC, JumpToObject(oTarget));
            ClearInventory(oPC);
            return;
        }
    }

    if (nFaction != 2)
    {
       oTarget = GetObjectByTag (GetLocalString(GetModule(), "FACTION_0" + IntToString(nFaction) + "_DREAMSTART"));
       AssignCommand (oPC, JumpToObject (oTarget));
    }
}
