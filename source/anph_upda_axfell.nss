
#include "hc_inc"
#include "anph_inc"


void main()
{
    object oPC = GetLastUsedBy();

    object oMaster = GetMaster(oPC);
    if (GetIsObjectValid(oMaster))
       return;

    object oTarget = GetObjectByTag(GetLocalString(oMod, "FACTION_02_STARTLOCATION"));
    object oItem;

    int nAlign;
    int nLawChaos;

    // Apply Racial Restrictions
    if (GetLocalInt(oMod, "ANPH_RACIAL_RESTRICTIONS") == TRUE)
    {

       {
          SendMessageToPC(oPC, "Your race is not welcome in Axfell.");
          return;
       }
    }

    // Check for alignment Restrictions
    if (GetLocalInt(oMod, "ANPH_ALIGNMENT_RESTRICTIONS") == TRUE)
    {
       nAlign = GetAlignmentGoodEvil (oPC);
       nLawChaos = GetAlignmentLawChaos (oPC);
       if (nAlign == ALIGNMENT_GOOD &&
           nLawChaos == ALIGNMENT_LAWFUL)
       {
           SendMessageToPC (oPC, "Lawful good characters aren't allowed in Axfell.");
           return;
       }
    }

    // Give oPC Items of Faction Axfell
    GiveFactionItems (oPC, 2);

oItem = GetItemPossessedBy(oPC,"anphilliaruleboo");
    if(GetIsObjectValid(oItem))
        DestroyObject(oItem);
    oItem = GetItemPossessedBy(oPC,"anphilliaruleboo");
    if(GetIsObjectValid(oItem))
        DestroyObject(oItem);

     CreateItemOnObject("anphilliaruleboo", oPC);
    CheckPlayerTeam (oPC);
    AssignCommand (oPC, JumpToObject(oTarget));
}

