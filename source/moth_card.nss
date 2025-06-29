#include "moth_inc_puzzle"
void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    string sDeck = "mothdeck";
    string sCard = "mothcard";
    string sFace = GetLocalString(oItem, "face");
    string sSuit = GetLocalString(oItem, "suit");
    string sUser = GetName(oUser);
    string sTarget = GetName(oTarget);
    string sHisHer;
    if(GetGender(oUser)==GENDER_FEMALE)
    {
      sHisHer = "her";
    }
    else
    {
     sHisHer = "his";
    }
    location lTarget = GetItemActivatedTargetLocation();
    if(GetTag(oItem)==sCard)
    {
        if(!GetIsObjectValid(oTarget))
        {
           MothShowCardHand(oUser);
        }
        else if(oUser==oTarget)
        {
            FloatingTextStringOnCreature("<c þ >This card is a " +
                sFace + " of " +
                sSuit + ".</c>", oUser, FALSE);
        }
        else if (GetIsPC(oTarget))
        {
            FloatingTextStringOnCreature("<c þ >"+sUser+" shows you a " +
                sFace + " of " +
                sSuit + ".</c>", oTarget, FALSE);
            FloatingTextStringOnCreature("<c þ >You show "+sTarget+" your " +
                sFace + " of " +
                sSuit + ".</c>", oUser, FALSE);
        }
        else if(oItem==oTarget)
        {
            FloatingTextStringOnCreature("<c þ >You flips over a " +
                sFace + " of " +
                sSuit + ".</c>", oUser, FALSE);
            MothFlipACard(oItem);
        }
        else if(GetTag(oTarget)==sDeck)
        {
            string face = GetLocalString(oItem, "face");
            string suit = GetLocalString(oItem, "suit");
            face = GetSubString(face, 0, 1);
            suit = GetSubString(suit, 0, 1);
            if(GetLocalInt(oTarget, face+suit)==0)
            {
                FloatingTextStringOnCreature("<cþ¥ >"+sUser+" adds a card to "+sHisHer+" deck...</c>", oUser, TRUE);
                SetLocalInt(oTarget, face+suit, 1);
                SetLocalInt(oTarget, "numCards", GetLocalInt(oTarget, "numCards")+1);
                SetName(oTarget, "A Deck of Cards (" + IntToString(GetLocalInt(oTarget, "numCards"))+ ")");
                if(GetLocalInt(oTarget, "numCards")==52)
                {
                    SetLocalInt(oTarget, "initialized", 0);
                    SetPlotFlag(oTarget, FALSE);
                }
                DestroyObject(oItem);
            }
            else
            {
                FloatingTextStringOnCreature("<cþ¥ >"+sUser+"'s deck already has this card!</c>", oUser, TRUE);
            }
        }

    }
}
