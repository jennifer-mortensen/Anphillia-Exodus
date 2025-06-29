#include "hc_inc"
#include "anph_inc"


void main()
{
    object oPC = GetLastUsedBy();

    object oMaster = GetMaster(oPC);
    if (GetIsObjectValid(oMaster))
       return;

    object oTarget = GetObjectByTag(GetLocalString(oMod, "FACTION_01_STARTLOCATION"));
    object oItem;
    int nAlign;
    int nLawChaos;


    // Check for racial Restrictions
    if (GetLocalInt(oMod, "ANPH_RACIAL_RESTRICTIONS") == TRUE)
    {

    }

    // never allow underdark races in cleaven


    // Check for alignment Restrictions
    if (GetLocalInt(oMod, "ANPH_ALIGNMENT_RESTRICTIONS") == TRUE)
    {
       nAlign = GetAlignmentGoodEvil (oPC);
       nLawChaos = GetAlignmentLawChaos (oPC);
       if (nAlign == ALIGNMENT_EVIL &&
           nLawChaos == ALIGNMENT_CHAOTIC)
       {
          SendMessageToPC (oPC, "Chaotic Evil Characters are not allowed in Cleaven.");
          return;
       }
    }

    // Give oPC Items of Faction 1
    GiveFactionItems (oPC, 1);

oItem = GetItemPossessedBy(oPC,"anphilliaruleboo");
    if(GetIsObjectValid(oItem))
        DestroyObject(oItem);
    oItem = GetItemPossessedBy(oPC,"anphilliaruleboo");
    if(GetIsObjectValid(oItem))
        DestroyObject(oItem);;

     CreateItemOnObject("anphilliaruleboo", oPC);
    CheckPlayerTeam (oPC);
    AssignCommand(oPC,JumpToObject(oTarget));
}

