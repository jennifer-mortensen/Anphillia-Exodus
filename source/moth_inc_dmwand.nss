// Handles added wand functions.
#include "moth_inc"

// * Allows DM to set the delay of music in an area.
void MothSetMusicDelay();
// * Allows DM to set battle music in an area.
void MothSetMusicBattle();
// * Allows DM to set night music in an area.
void MothSetMusicNight();
// * Allows DM to set day music in an area.
void MothSetMusicDay();
// * Allows DM to set a name to an Object.
void MothSetName();
// * Allows DM to set the description on an item.
void MothSetDescription();
// * Allows DM to set descriptions to unidentified on an item.
void MothSetDescriptionUnID();
// * Allows DM to set a appearance of a creature.
void MothSetAppearance();
// * Allows DM to set a wings of a creature.
void MothSetWings();
// * Allows DM to set a visual to an Object.
void MothSetVisual();
// * Allows DM to set a tail of a creature.
void MothSetTail();
// * Allows DM to set a portrait of an Object.
void MothSetPortrait();
// * Pickpock toggle wand.
//Enables autobooting of Players with Pickpocket skill
void MothPPEnable(object oMod);
// * Pickpock toggle wand.
//Disables autobooting of Players with Pickpocket skill
void MothPPDisable(object oMod);
// * Handles prisonwand.
void MothPrisonWand(object oPC = OBJECT_SELF);
// * Rolls a Dice with colorcoded feedback.
void MothDiceRoll(int nRoll, string sDice, string sColor="");
// * Rolls an Ability with colorcoded feedback.
void MothAbilityRoll(int nRank, string sAbility, string sColor="");
// * Rolls a Skill with colorcoded feedback.
void MothSkillRoll(int nRank2,string sAbility);
// * Sets the name of a container (now changed to accept any item in the users inventory).
void MothRenameBag();




// Customize NPC, PC or Area wand.
void MothSetMusicDelay()
{
    object oDM = GetPCSpeaker();
    object oTarget = GetArea(oDM);
    string sSkillName = GetLocalString(oDM, "ats_sw_current_skill");
    int iAdjustAmount = GetLocalInt(oDM, "ats_sw_adjust_value");
    MusicBackgroundSetDelay(oTarget,iAdjustAmount);
}
void MothSetMusicBattle()
{
    object oDM = GetPCSpeaker();
    object oTarget = GetArea(oDM);
    string sSkillName = GetLocalString(oDM, "ats_sw_current_skill");
    int iAdjustAmount = GetLocalInt(oDM, "ats_sw_adjust_value");
    MusicBattleChange(oTarget,iAdjustAmount);
}
void MothSetMusicNight()
{
    object oDM = GetPCSpeaker();
    object oTarget = GetArea(oDM);
    string sSkillName = GetLocalString(oDM, "ats_sw_current_skill");
    int iAdjustAmount = GetLocalInt(oDM, "ats_sw_adjust_value");
    MusicBackgroundChangeNight(oTarget,iAdjustAmount);
}
void MothSetMusicDay()
{
    object oDM = GetPCSpeaker();
    object oTarget = GetArea(oDM);
    string sSkillName = GetLocalString(oDM, "ats_sw_current_skill");
    int iAdjustAmount = GetLocalInt(oDM, "ats_sw_adjust_value");
    MusicBackgroundChangeDay(oTarget,iAdjustAmount);
}
void MothSetName()
{
    object oDM = GetPCSpeaker();
    object oPC = GetItemActivatedTarget();
    object oTarget = GetLocalObject(oDM, "ats_item_target");
    string sSkillName = GetLocalString(oDM, "moth_rename_NPC");
    SetName(oPC,sSkillName);
}
void MothSetDescription()
{
    object oDM = GetPCSpeaker();
    object oPC = GetItemActivatedTarget();
    object oTarget = GetLocalObject(oDM, "ats_item_target");
    string sSkillDescription = GetLocalString(oDM, "moth_rename_NPC");
    SetDescription(oPC,sSkillDescription);
}
void MothSetDescriptionUnID()
{
    object oDM = GetPCSpeaker();
    object oPC = GetItemActivatedTarget();
    object oTarget = GetLocalObject(oDM, "ats_item_target");
    string sSkillDescription = GetLocalString(oDM, "moth_rename_NPC");
    SetDescription(oPC,sSkillDescription,FALSE);
}
void MothSetAppearance()
{
    object oDM = GetPCSpeaker();
    object oPC = GetItemActivatedTarget();
    object oTarget = GetLocalObject(oDM, "ats_item_target");
    string sSkillName = GetLocalString(oDM, "ats_sw_current_skill");
    int iAdjustAmount = GetLocalInt(oDM, "ats_sw_adjust_value");
    SetCreatureAppearanceType(oPC,iAdjustAmount);
}
void MothSetWings()
{
    object oDM = GetPCSpeaker();
    object oPC = GetItemActivatedTarget();
    object oTarget = GetLocalObject(oDM, "ats_item_target");
    string sSkillName = GetLocalString(oDM, "ats_sw_current_skill");
    int iAdjustAmount = GetLocalInt(oDM, "ats_sw_adjust_value");
    SetCreatureWingType(iAdjustAmount,oPC);
}
void MothSetVisual()
{
    object oDM = GetPCSpeaker();
    object oPC = GetItemActivatedTarget();
    object oTarget = GetLocalObject(oDM, "ats_item_target");
    string sSkillName = GetLocalString(oDM, "ats_sw_current_skill");
    int iAdjustAmount = GetLocalInt(oDM, "ats_sw_adjust_value");
    effect ePer = EffectVisualEffect(iAdjustAmount);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,oPC);
}
void MothSetTail()
{
    object oDM = GetPCSpeaker();
    object oPC = GetItemActivatedTarget();
    object oTarget = GetLocalObject(oDM, "ats_item_target");
    string sSkillName = GetLocalString(oDM, "ats_sw_current_skill");
    int iAdjustAmount = GetLocalInt(oDM, "ats_sw_adjust_value");
    SetCreatureTailType(iAdjustAmount,oPC);
}
void MothSetPortrait()
{
    object oDM = GetPCSpeaker();
    object oPC = GetItemActivatedTarget();
    object oTarget = GetLocalObject(oDM, "ats_item_target");
    string sSkillName = GetLocalString(oDM, "ats_sw_current_skill");
    int iAdjustAmount = GetLocalInt(oDM, "ats_sw_adjust_value");
    SetPortraitId(oPC,iAdjustAmount);
}
// Pickpock toggle wand
void MothPPEnable(object oMod)
{
    DelayCommand(1.0,SetLocalInt(oMod, "PPAutoBoot", FALSE));
    FloatingTextStringOnCreature("<c¥  >*Pickpocketing Auto-Boot Enabled*</c>",OBJECT_SELF);
}
void MothPPDisable(object oMod)
{
    DelayCommand(1.0,SetLocalInt(oMod, "PPAutoBoot", TRUE));
    FloatingTextStringOnCreature("<c ¥ >*Pickpocketing Auto-Boot Disabled*</c>",OBJECT_SELF);
}
// Prison wand
void MothPrisonWand(object oPC = OBJECT_SELF)
{
    location lLocation = GetLocation(oPC);
    object oPortal;
    string sNewTag;

    if (GetLocalString(oPC,"MothSetFactionInt") == "MothAxfellMember")
    {
        sNewTag = "axfell_portal";
    }
    else if (GetLocalString(oPC,"MothSetFactionInt") == "MothCleavenMember")
    {
        sNewTag = "cleaven_portal";
    }
    else return;

    oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "prisport", lLocation, FALSE, sNewTag);
    DestroyObject(oPortal, 60.0f);
}
// Emotewand dice rolls
void MothDiceRoll(int nRoll, string sDice, string sColor="")
{
   object oPC = GetLastSpeaker();
   string sName = GetName(oPC);
   string sRoll=IntToString(nRoll);
   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,3.0,3.0));
   DelayCommand(2.0,AssignCommand(oPC,SpeakString(sColor+sName+" rolled a "+sDice+" and gets a: "+sRoll+"</c>")));
}
void MothAbilityRoll(int nRank, string sAbility, string sColor="")
{
   object oPC = GetLastSpeaker();
   int nRoll=d20();
   int nAbility = GetAbilityModifier(nRank);
   int nResult=nRoll+nAbility;
   string sRoll=IntToString(nRoll);
   string sRank=IntToString(nAbility);
   string sResult=IntToString(nResult);
   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,3.0,3.0));
   AssignCommand(oPC,SpeakString(sColor+sAbility+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult+"</c>"));

}
void MothSkillRoll(int nRank2,string sAbility)
{
   object oPC = GetLastSpeaker();
   int nRoll=d20();
   int nRank=GetSkillRank (nRank2, oPC);
   int nResult=nRoll+nRank;
   string sColor="<cþÞ >";
   string sRoll=IntToString(nRoll);
   string sRank=IntToString(nRank);
   string sResult=IntToString(nResult);
   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,3.0,3.0));
   AssignCommand(oPC,SpeakString(sColor+sAbility+" Check, Roll: "+sRoll+" Modifier: "+sRank+" = "+sResult+"</c>"));

}
void MothRenameBag()
{
    object oPC = GetPCSpeaker();
    object oBag = GetItemActivatedTarget();
    if(GetItemPossessor(oBag)!=oPC)
    {
        SendMessageToPC(oPC, "<cþÞ >*Target must be in your inventory!*</c>");
        return;
    }
    object oTarget = GetLocalObject(oPC, "ats_item_target");
    string sItemName = GetLocalString(oPC, "moth_rename_bag");
    SetName(oBag,sItemName);
}
void MothSetDroppable()
{
    object oObject = GetItemActivatedTarget();
    SetDroppableFlag(oObject, TRUE);
}
void MothSetUndroppable()
{
    object oObject = GetItemActivatedTarget();
    SetPlotFlag(oObject, FALSE);
}
void MothSetId()
{
    object oObject = GetItemActivatedTarget();
    SetIdentified(oObject, TRUE);
}
void MothSetUnId()
{
    object oObject = GetItemActivatedTarget();
    SetIdentified(oObject, FALSE);
}
void MothSetPlot()
{
    object oObject = GetItemActivatedTarget();
    SetPlotFlag(oObject, TRUE);
}
void MothSetUnplot()
{
    object oObject = GetItemActivatedTarget();
    SetPlotFlag(oObject, TRUE);
}
int MothGetIsEncounter()
{
    object oObject = GetItemActivatedTarget();
    if(GetObjectType(oObject) == OBJECT_TYPE_ENCOUNTER)
    {
     return TRUE;
    }
   return FALSE;
}
void MothActivateEncounter()
{
    object oObject = GetItemActivatedTarget();
    if(!GetEncounterActive(oObject))
    {
    SetEncounterActive(TRUE,oObject);
    }
}
void MothDeactivateEncounter()
{
    object oObject = GetItemActivatedTarget();
    if(GetEncounterActive(oObject))
    {
    SetEncounterActive(FALSE,oObject);
    }
}
void MothSetEncounterDifficulty1()
{
    object oObject = GetItemActivatedTarget();
    SetEncounterDifficulty(ENCOUNTER_DIFFICULTY_VERY_EASY,oObject);
}
void MothSetEncounterDifficulty2()
{
    object oObject = GetItemActivatedTarget();
    SetEncounterDifficulty(ENCOUNTER_DIFFICULTY_EASY,oObject);
}
void MothSetEncounterDifficulty3()
{
    object oObject = GetItemActivatedTarget();
    SetEncounterDifficulty(ENCOUNTER_DIFFICULTY_NORMAL,oObject);
}
void MothSetEncounterDifficulty4()
{
    object oObject = GetItemActivatedTarget();
    SetEncounterDifficulty(ENCOUNTER_DIFFICULTY_HARD,oObject);
}
void MothSetEncounterDifficulty5()
{
    object oObject = GetItemActivatedTarget();
    SetEncounterDifficulty(ENCOUNTER_DIFFICULTY_IMPOSSIBLE,oObject);
}
//void main(){}
