
#include "ats_inc_common"
#include "ats_const_common"
#include "ats_const_skill"
#include "ats_const_recipe"
#include "ats_config"
#include "ats_inc_skill"
/*
void ATS_CheckForRemovedNoDropItems(object oPlayer, object oItemLost)
{

    string sItemTag = GetTag(oItemLost);
    SetLocalObject(oItemLost, "ats_prev_possessor", oPlayer);

    // Item lost was a token or no drop item
    if(GetStringLeft(sItemTag, GetStringLength(CSTR_TOKEN_TAG)) == CSTR_TOKEN_TAG ||
        ATS_IsItemNoDrop(oItemLost) == TRUE)
    {
        if(GetItemPossessor(oItemLost) == oPlayer)
            return;

        vector vItemPos = GetPositionFromLocation(GetLocation(oItemLost));
        vector vPlayerPos = GetPositionFromLocation(GetLocation(oPlayer));

        if( vItemPos == Vector() && GetIsObjectValid(GetItemPossessor(oItemLost)) == FALSE)
            return;

        int iQuantity = GetNumStackedItems(oItemLost);
        DestroyObject(oItemLost);

        object oNewItem = CreateItemOnObject(ATS_GetResRefFromTag(sItemTag), oPlayer, iQuantity);

        if(sItemTag == CSTR_PERSISTENT_SKILLS_BOXTAG)
        {
            string sTradeSkillType;
            int iSkillValue;
            int i;
            for(i = 1; i <= CINT_SKILL_COUNT; ++i)
            {
                sTradeSkillType = ATS_GetTradeskillName(i);
                iSkillValue = ATS_GetTradeskill(oPlayer, sTradeSkillType);
                if(iSkillValue > 0)
                {
                    string sToken1Tag = ATS_GetSkillTokenTag(sTradeSkillType, 1);
                    string sToken100Tag = ATS_GetSkillTokenTag(sTradeSkillType, 100);

                    object oNewToken1;
                    object oNewToken100;

                    ATS_DestroyTokens(oPlayer, sToken1Tag);
                    ATS_DestroyTokens(oPlayer, sToken100Tag);

                    int iValue100 = iSkillValue / 100;
                    int iValue1 = iSkillValue - (iValue100 * 100);

                    ATS_CreateSkillToken(oPlayer, ATS_GetResRefFromTag(sToken1Tag), iValue1);
                    ATS_CreateSkillToken(oPlayer, ATS_GetResRefFromTag(sToken100Tag), iValue100);

                }
            }
        }
        FloatingTextStringOnCreature("You cannot remove this.", oPlayer, FALSE);
    }
}

void ATS_AssignPossessorToNoDropItems(object oPlayer, object oItemAcquired)
{
    string sItemTag = GetTag(oItemAcquired);

    object oAcquiredFrom = GetLocalObject(oItemAcquired, "ats_prev_possessor");

    if( (GetStringLeft(sItemTag, GetStringLength(CSTR_TOKEN_TAG))) == CSTR_TOKEN_TAG ||
        ATS_IsItemNoDrop(oItemAcquired))
    {
        // Check to see if nodrop item was traded
        if(GetIsObjectValid(oAcquiredFrom) == TRUE
           && oAcquiredFrom !=oPlayer)
        {
            ATS_CreateSkillToken(oAcquiredFrom, ATS_GetResRefFromTag(sItemTag),
                                GetNumStackedItems(oItemAcquired));
            DestroyObject(oItemAcquired);
            FloatingTextStringOnCreature("You cannot trade this.", oAcquiredFrom, FALSE);

        }
        else
        {
            //Move tokens into skill box
            if( GetStringLeft(sItemTag, GetStringLength(CSTR_TOKEN_TAG)) == CSTR_TOKEN_TAG)
            {
                object oSkillBox = GetItemPossessedBy(oPlayer, CSTR_PERSISTENT_SKILLS_BOXTAG);
                AssignCommand(oPlayer, ActionGiveItem(oItemAcquired, oSkillBox) );
            }
            SetLocalObject(oItemAcquired, "ats_obj_possessor", oPlayer);
        }
    }
}*/
