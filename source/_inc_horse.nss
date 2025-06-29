//::///////////////////////////////////////////////
//:: Horse Function Library
//:: _inc_horse
//:://////////////////////////////////////////////
/*
    Contains functions for handling horses.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 23, 2010
//:://////////////////////////////////////////////

#include "x3_inc_horse"
#include "zep_inc_phenos2"

//Handles horse-related settings for oPC on death.
void HandleHorseSettingsOnDeath(object oPC);
//Initializes horse settings for oPC. Call this the first time a character enters the mod.
void InitializeHorseSettings(object oPC);

//::///////////////////////////////////////////////
//:: HandleHorseSettingsOnDeath
//:://////////////////////////////////////////////
/*
    Handles horse-related settings for oPC on
    death.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 23, 2010
//:://////////////////////////////////////////////
void HandleHorseSettingsOnDeath(object oPC)
{
    zep_Dismount(oPC);
    object oHorse;
    object oInventory;
    string sID;
    int nC;
    string sT;
    string sR;
    int nCH;
    int nST;
    object oItem;
    effect eEffect;
    string sDB="X3SADDLEBAG"+GetTag(GetModule());
    if (GetStringLength(GetLocalString(GetModule(),"X3_SADDLEBAG_DATABASE"))>0) sDB=GetLocalString(GetModule(),"X3_SADDLEBAG_DATABASE");
    if (HorseGetIsMounted(oPC))
    { // Dismount and then die
        //SetCommandable(FALSE,oPC);
        //ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
        DelayCommand(0.3,HORSE_SupportResetUnmountedAppearance(oPC));
        DelayCommand(3.0,HORSE_SupportCleanVariables(oPC));
        DelayCommand(1.0,HORSE_SupportRemoveACBonus(oPC));
        DelayCommand(1.0,HORSE_SupportRemoveHPBonus(oPC));
        DelayCommand(1.1,HORSE_SupportRemoveMountedSkillDecreases(oPC));
        DelayCommand(1.1,HORSE_SupportAdjustMountedArcheryPenalty(oPC));
        DelayCommand(1.2,HORSE_SupportOriginalSpeed(oPC));
        if (!GetLocalInt(GetModule(),"X3_HORSE_NO_CORPSES"))
        { // okay to create lootable horse corpses
            sR=GetSkinString(oPC,"sX3_HorseResRef");
            sT=GetSkinString(oPC,"sX3_HorseMountTag");
            nCH=GetSkinInt(oPC,"nX3_HorseAppearance");
            nST=GetSkinInt(oPC,"nX3_HorseTail");
            nC=GetLocalInt(oPC,"nX3_HorsePortrait");
            if (GetStringLength(sR)>0&&GetStringLeft(sR,GetStringLength(HORSE_PALADIN_PREFIX))!=HORSE_PALADIN_PREFIX)
            { // create horse
                oHorse=HorseCreateHorse(sR,GetLocation(oPC),oPC,sT,nCH,nST);
                SetLootable(oHorse,TRUE);
                SetPortraitId(oHorse,nC);
                SetLocalInt(oHorse,"bDie",TRUE);
                AssignCommand(oHorse,SetIsDestroyable(FALSE,TRUE,TRUE));
            } // create horse
        } // okay to create lootable horse corpses
        oInventory=GetLocalObject(oPC,"oX3_Saddlebags");
        sID=GetLocalString(oPC,"sDB_Inv");
        if (GetIsObjectValid(oInventory))
        { // drop horse saddlebags
            if (!GetIsObjectValid(oHorse))
            { // no horse created
                HORSE_SupportTransferInventory(oInventory,OBJECT_INVALID,GetLocation(oPC),TRUE);
            } // no horse created
            else
            { // transfer to horse
                HORSE_SupportTransferInventory(oInventory,oHorse,GetLocation(oHorse),TRUE);
                //DelayCommand(2.0,PurgeSkinObject(oHorse));
                //DelayCommand(3.0,KillTheHorse(oHorse));
                //DelayCommand(1.8,PurgeSkinObject(oHorse));
            } // transfer to horse
        } // drop horse saddlebags
        else if (GetStringLength(sID)>0)
        { // database based inventory
            nC=GetCampaignInt(sDB,"nCO_"+sID);
            while(nC>0)
            { // restore inventory
                sR=GetCampaignString(sDB,"sR"+sID+IntToString(nC));
                sT=GetCampaignString(sDB,"sT"+sID+IntToString(nC));
                nST=GetCampaignInt(sDB,"nS"+sID+IntToString(nC));
                nCH=GetCampaignInt(sDB,"nC"+sID+IntToString(nC));
                DeleteCampaignVariable(sDB,"sR"+sID+IntToString(nC));
                DeleteCampaignVariable(sDB,"sT"+sID+IntToString(nC));
                DeleteCampaignVariable(sDB,"nS"+sID+IntToString(nC));
                DeleteCampaignVariable(sDB,"nC"+sID+IntToString(nC));
                if (!GetIsObjectValid(oHorse))
                { // no lootable corpse
                    oItem=CreateObject(OBJECT_TYPE_ITEM,sR,GetLocation(oPC),FALSE,sT);
                } // no lootable corpse
                else
                { // lootable corpse
                    oItem=CreateItemOnObject(sR,oHorse,nST,sT);
                } // lootable corpse
                if (GetItemStackSize(oItem)!=nST) SetItemStackSize(oItem,nST);
                if (nCH>0) SetItemCharges(oItem,nCH);
                nC--;
            } // restore inventory
            DeleteCampaignVariable(sDB,"nCO_"+sID);
            //DelayCommand(2.0,PurgeSkinObject(oHorse));
            if (GetIsObjectValid(oHorse)&&GetLocalInt(oHorse,"bDie")) DelayCommand(3.0,KillTheHorse(oHorse));
            //DelayCommand(2.5,PurgeSkinObject(oHorse));
        } // database based inventory
        else if (GetIsObjectValid(oHorse))
        { // no inventory
            //DelayCommand(1.0,PurgeSkinObject(oHorse));
            DelayCommand(2.0,KillTheHorse(oHorse));
            //DelayCommand(1.8,PurgeSkinObject(oHorse));
        } // no inventory
        //eEffect=EffectDeath();
        //DelayCommand(1.6,ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oPC));
        //DelayCommand(1.7,SetCommandable(TRUE,oPC));
        //return;
    } // Dismount and then die
}

//::///////////////////////////////////////////////
//:: InitializeHorseSettings
//:://////////////////////////////////////////////
/*
    Initializes horse settings for oPC. Call this
    the first time a character enters the mod.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 23, 2010
//:://////////////////////////////////////////////
void InitializeHorseSettings(object oPC)
{
    if (!GetSkinInt(oPC,"bX3_IS_MOUNTED")) HorseIfNotDefaultAppearanceChange(oPC);
        HorsePreloadAnimations(oPC);
    DelayCommand(3.0,HorseRestoreHenchmenLocations(oPC));
}
