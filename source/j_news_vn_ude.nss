//::///////////////////////////////////////////////
//:: Name Vendor: Shouting!
//:: FileName j_news_vn_ude
//:://////////////////////////////////////////////
/*
    Every so often, from 30 seconds to 1 minute, we
    may shout if there is a PC near, a PC in the area and not in conversation

    Shouts the title, with a random for page.
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

// Sets up the campaing database values to shout
int SetToUseStrings();
// Says a random shout.
void RandomShout(string sSaying);

void main()
{
    if(GetIsDead(OBJECT_SELF) || !GetIsObjectValid(OBJECT_SELF)) return;
    int iUDE, iRandom, iSize, iRandomArray;
    iUDE = GetUserDefinedEventNumber();
    float fRandom, fDistance;
    object oPC, oTorch, oLefthand;
    string sShout;
    if(iUDE == VENDOR_UDE_NUMBER)
    {
        iRandom = RANDOM_SHOUT_DELAY_DAY;// Defaults to 30
        if(GetCommandable() && !IsInConversation(OBJECT_SELF) &&
           !GetIsInCombat() && !GetIsObjectValid(GetAttackTarget()))
        {
            oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
            fDistance = GetDistanceToObject(oPC);
            if(GetIsObjectValid(oPC) && fDistance > 0.0 && fDistance < 60.0)
            {
                // Stop now to shout
                ClearAllActions();
                oLefthand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
                if(GetIsNight())
                {
                    iRandom = RANDOM_SHOUT_DELAY_NIGHT;// Sometimes more random when night. Def: 50
                    if(GetTag(oLefthand) != TORCH_TAG)
                    {
                        oTorch = GetItemPossessedBy(OBJECT_SELF, TORCH_TAG);
                        if(GetIsObjectValid(oTorch) &&
                           oLefthand != oTorch)
                        {
                            ActionEquipItem(oTorch, INVENTORY_SLOT_LEFTHAND);
                        }
                    }
                }
                else if(GetBaseItemType(oLefthand) == BASE_ITEM_TORCH)
                {
                    ActionUnequipItem(oLefthand);
                }
                iSize = SetToUseStrings();
                if(iSize)
                {
                    // Simulate dice roll...choose one
                    iRandomArray = Random(iSize - 1) + 1;
                    // Get it
                    sShout = GetLocalString(OBJECT_SELF, ARRAY_SHOUT + IntToString(iRandomArray));
                    if(sShout != "")
                    {
                        RandomShout(sShout);
                    }
                }
            }
        }
        fRandom = IntToFloat(Random(iRandom));
        DelayCommand(BASE_SHOUT_DELAY + fRandom,  SignalEvent(OBJECT_SELF, EventUserDefined(VENDOR_UDE_NUMBER)));
    }
}


int SetToUseStrings()
{
    int i, iReady;
    string sContent;
    // First: Titles: TITLE_1 to TITLE_10 (max: 50 letters)
    for(i = 1; i <= i10; i++)
    {
        sContent = News_GetDatabaseString(TITLE_ + IntToString(i));
        if(sContent != NOTHING && sContent != "")
        {
            iReady++;
            // Set title
            SetLocalString(OBJECT_SELF, ARRAY_SHOUT + IntToString(iReady), sContent);
        }
    }
    return iReady;
}

void RandomShout(string sSaying)
{
    int iRandom = d10();
    // 1.1, changed a little here to make 100% it uses a sSaying
    string sWeSay;
    switch(iRandom)
    {
        case 1: sWeSay = VENDOR_SHOUT_ONE; break;
        case 2: sWeSay = VENDOR_SHOUT_TWO; break;
        case 3: sWeSay = VENDOR_SHOUT_THREE; break;
        case 4: sWeSay = VENDOR_SHOUT_FOUR; break;
        case 5: sWeSay = VENDOR_SHOUT_FIVE; break;
        case 6: sWeSay = VENDOR_SHOUT_SIX; break;
        case 7: sWeSay = VENDOR_SHOUT_SEVEN; break;
        case 8: sWeSay = VENDOR_SHOUT_EIGHT; break;
        case 9: sWeSay = VENDOR_SHOUT_NINE; break;
        case 10: sWeSay = VENDOR_SHOUT_TEN; break;
        default: sWeSay = VENDOR_SHOUT_ONE; break;
    }
    // Add it all together (Added a ! as well)
    sWeSay += " " + sSaying + "!";
    SpeakString(sWeSay);
    // Should do the "Yeah!" animation , where the fist goes up.
    PlayAnimation(ANIMATION_FIREFORGET_VICTORY1);
}
