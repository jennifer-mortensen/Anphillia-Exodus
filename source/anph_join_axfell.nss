#include "hc_inc"
#include "anph_inc"
#include "_inc_xp"
#include "_inc_summons"
#include "_inc_gen"
void main()
{
    int STARTING_LEVEL = 4;
    //int STARTING_GOLD = 25000;

    object oPC = GetLastUsedBy();
    object oMaster = GetMaster(oPC);
    object oTarget = GetObjectByTag(GetLocalString(oMod, "FACTION_02_STARTLOCATION"));
    object oItem;
    int nECL = GetECL(oPC);

    if (GetIsObjectValid(oMaster))
       return;

    int nPickpocket = GetSkillRank(SKILL_PICK_POCKET, oPC, TRUE);
    if(nPickpocket >= 1)
    {
        SendMessageToPC(oPC, "The pickpocket skill is disallowed on Anphillia Exodus. Please build a new character without it.");
        return;
    }

    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
       {
        if(!GetLocalInt(oPC, "FACTION_JOINED"))
        {
            GiveFactionItems (oPC, 2);
            GiveStarterGear(oPC, FACTION_AXFELL);
            int nLevelsToGive = STARTING_LEVEL - GetLevelFromXP(oPC) - nECL;
            if(nLevelsToGive > 0)
                GiveLevel(oPC, nLevelsToGive);
            CheckPlayerTeam (oPC);
            if(GetIsObjectValid(GetItemPossessedBy(oPC,"MothBattleHorn"))==FALSE)
                CreateItemOnObject("mothbattlehorn", oPC);
            SetToFactionDefaultSummonTypes(oPC, FACTION_AXFELL, FALSE, TRUE);
            DeleteLocalString(oPC,"MothSetFactionInt");
            SetLocalString(oPC,"MothSetFactionInt","MothAxfellMember");
            SetLocalInt(oPC, "FACTION_JOINED", 1);
        }
        AssignCommand(oPC,JumpToObject(oTarget));
        }
     else
        {
         SendMessageToPC (oPC, "Only Evil Alignment characters are allowed in Axfell!");
        }

}

