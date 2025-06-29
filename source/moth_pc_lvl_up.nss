#include "tk_hips_inc"
#include "moth_inc"
#include "moth_inc_spells"
#include "moth_inc_effects"
#include "_inc_xp"
#include "_inc_items"
#include "_inc_gen"
#include "_inc_db"

void main()
{
    object oPC = GetPCLevellingUp();

    //J. Persinne; initialize variables for legal level up check.
    int nBlackguardLevels = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC);
    int nPaladinLevels = GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
    int nSorcererLevels = GetLevelByClass(CLASS_TYPE_SORCERER, oPC);
    int nMonkLevels = GetLevelByClass(CLASS_TYPE_MONK, oPC);
    int nMaxStunningFistFeats = 6;
    int nTotalStunningFistFeats;
    int nCurrentXP = GetXP(oPC);
    int nLevel = GetHitDice(oPC);
    int nPickpocket = GetSkillRank(SKILL_PICK_POCKET, oPC, TRUE);

    if(nMonkLevels >= 32)
        nMaxStunningFistFeats = (nMonkLevels - 30) / 2;

    if(GetHasFeat(FEAT_EPIC_IMPROVED_STUNNING_FIST_10, oPC))
        nTotalStunningFistFeats = 10;
    else if(GetHasFeat(FEAT_EPIC_IMPROVED_STUNNING_FIST_9, oPC))
        nTotalStunningFistFeats = 9;
    else if(GetHasFeat(FEAT_EPIC_IMPROVED_STUNNING_FIST_8, oPC))
        nTotalStunningFistFeats = 8;
    else if(GetHasFeat(FEAT_EPIC_IMPROVED_STUNNING_FIST_7, oPC))
        nTotalStunningFistFeats = 7;

    //J. Persinne; check to ensure that the level up was legal.  If not, delevel the character and refund experience.
    if(nBlackguardLevels >= 1 && nSorcererLevels >= 1)
    {
        //J. Persinne; the character has both blackguard and sorcerer levels.
        GiveLevel(oPC, -1);
        SetXP(oPC, GetXPRequiredForLevel(nLevel) - 1);
        SetXP(oPC, nCurrentXP);
        if(GetLevelByClass(CLASS_TYPE_SORCERER, oPC) >= 1)
        {
            SendMessageToPC(oPC, "<cеее>[Server] Sorcerers cannot take blackguard levels.</c>");
        }
        else
        {
            SendMessageToPC(oPC, "<cеее>[Server] Blackguards cannot take sorcerer levels.</c>");
        }
    }
    else if(nPaladinLevels >= 1 && nSorcererLevels >= 1)
    {
        //J. Persinne; the character has both paladin and sorcerer levels.
        SetXP(oPC, GetXPRequiredForLevel(nLevel) - 1);
        SetXP(oPC, nCurrentXP);
        if(GetLevelByClass(CLASS_TYPE_SORCERER, oPC) >= 1)
        {
            SendMessageToPC(oPC, "<cеее>[Server] Sorcerers cannot take paladin levels.</c>");
        }
        else
        {
            SendMessageToPC(oPC, "<cеее>[Server] Paladins cannot take sorcerer levels.</c>");
        }
    }
    else if(nTotalStunningFistFeats > nMaxStunningFistFeats)
    {
        //J. Persinne; the character has too many Improved Stunning Fist feats.
        SetXP(oPC, GetXPRequiredForLevel(nLevel) - 1);
        SetXP(oPC, nCurrentXP);
        SendMessageToPC(oPC, "<cеее>[Server] You have been deleveled because you had more Improved Stunning Fist feats than your character allows.</c>");
    }
    else if(nPickpocket >= 1)
    {
        SetXP(oPC, GetXPRequiredForLevel(nLevel) - 1);
        SetXP(oPC, nCurrentXP);
        SendMessageToPC(oPC, "<cеее>[Server] You have been deleveled because you tried to take the pickpocket skill.</c>");
    }
    else if(GetIsPolymorphed(oPC))
    {
        SetXP(oPC, GetXPRequiredForLevel(nLevel) - 1);
        SetXP(oPC, nCurrentXP);
        SendMessageToPC(oPC, "<cеее>[Server] You cannot level while polymorphed.</c>");
    }
    else
    {
       MothGiveHalfOrcItem(oPC);
       MothSetShifterLevels(oPC);
       MothSetIsPMCaster(oPC);
       //MothPPLevel(oPC);
       MothBonuses(oPC);
       TK_HiPS_OnFeatChange(oPC);
       DelayCommand(0.5,MothUpdateHideFeats(oPC));
       HandleDMNoteRequirementsForAllItems(oPC);
       ExportSingleCharacter(oPC);
       SavePCDatabaseVariables(oPC);
    }
}
