#include "moth_inc_puzzle"
void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    location lTarget = GetItemActivatedTargetLocation();
    string sDeck = "mothdeck";
    string sCard = "mothcard";
    string sFace = GetLocalString(oItem, "face");
    string sSuit = GetLocalString(oItem, "suit");
    string sUser = GetName(oUser);
    string sTarget = GetName(oTarget);
    string sHimselfHerself;
    if(GetGender(oUser)==GENDER_FEMALE)
    {
      sHimselfHerself = "herself";
    }
    else
    {
     sHimselfHerself = "himself";
    }
    if(GetTag(oItem)==sDeck)
    {
        if(GetLocalInt(oItem, "initialized")!=0)
        {
            if(GetLocalInt(oItem, "numCards")==0)
            {
                FloatingTextStringOnCreature("<cþ¥ >There are no more cards to deal!", oUser, TRUE);
                return;
            }
            int sc = TRUE;
            string card = "EE";
            while(sc == TRUE)
            {
                string suit = "E";
                switch (Random(8))
                {
                    case 0: suit = "S"; break;
                    case 1: suit = "D"; break;
                    case 2: suit = "H"; break;
                    case 3: suit = "C"; break;
                    case 4: suit = "S"; break;
                    case 5: suit = "D"; break;
                    case 6: suit = "H"; break;
                    case 7: suit = "C"; break;
                }
                string face = "E";
                switch(Random(13))
                {
                    case 0: face = "A"; break;
                    case 1: face = "K"; break;
                    case 2: face = "Q"; break;
                    case 3: face = "J"; break;
                    case 4: face = "10"; break;
                    case 5: face = "9"; break;
                    case 6: face = "8"; break;
                    case 7: face = "7"; break;
                    case 8: face = "6"; break;
                    case 9: face = "5"; break;
                    case 10: face = "4"; break;
                    case 11: face = "3"; break;
                    case 12: face = "2"; break;
                }
                card = face + suit;
                if(GetLocalInt(oItem, card)!=0) sc=FALSE;
            }
            object oCard;
            if(!GetIsObjectValid(oTarget) && GetLocalInt(oUser,"mothdealfacedown")==FALSE)
            {
               FloatingTextStringOnCreature("<cþ¥ >"+sUser+" Deals a card Face-up on the ground.</c>", oUser, TRUE);
               oCard = CreateObject(OBJECT_TYPE_ITEM, "mothcard", lTarget, FALSE);
            }
            if(!GetIsObjectValid(oTarget) && GetLocalInt(oUser,"mothdealfacedown")==TRUE)
            {
               FloatingTextStringOnCreature("<cþ¥ >"+sUser+" Deals a card Face-down on the ground.</c>", oUser, TRUE);
               oCard = CreateObject(OBJECT_TYPE_ITEM, "mothcard", lTarget, FALSE);
            }
            else if(oUser==oTarget && GetLocalInt(oUser,"mothdealfacedown")==FALSE)
            {
                FloatingTextStringOnCreature("<cþ¥ >"+sUser+" Deals a Face-up card to "+sHimselfHerself+".</c>", oUser, TRUE);
                oCard = CreateItemOnObject("mothcard", oTarget, 1);
            }
            else if(oUser==oTarget && GetLocalInt(oUser,"mothdealfacedown")==TRUE)
            {
                FloatingTextStringOnCreature("<cþ¥ >"+sUser+" Deals a Face-down card to "+sHimselfHerself+".</c>", oUser, TRUE);
                oCard = CreateItemOnObject("mothcard", oTarget, 1);
            }
            else if(oTarget==oItem)
            {
                if(GetLocalInt(oUser,"mothdealfacedown")==TRUE)
                {
                FloatingTextStringOnCreature("<cþ¥ >"+sUser+" toggles dealing to Face-up Dealing.</c>", oUser, TRUE);
                SetLocalInt(oUser,"mothdealfacedown",FALSE);
                }
                else if(GetLocalInt(oUser,"mothdealfacedown")==FALSE)
                {
                FloatingTextStringOnCreature("<cþ¥ >"+sUser+" toggles dealing to Face-down Dealing.</c>", oUser, TRUE);
                SetLocalInt(oUser,"mothdealfacedown",TRUE);
                }
            }
            else if(GetIsObjectValid(oTarget))
            {
                if(GetIsPC(oTarget) && GetLocalInt(oUser,"mothdealfacedown")==FALSE)
                {
                    FloatingTextStringOnCreature("<cþ¥ >"+sUser+" Deals a Face-up card to "+sTarget+".</c>", oUser, TRUE);
                    FloatingTextStringOnCreature("<cþ¥ >"+sTarget+" Gets a Face-up card dealt from "+sUser+".</c>", oTarget, TRUE);
                    oCard = CreateItemOnObject("mothcard", oTarget, 1);
                }
                if(GetIsPC(oTarget) && GetLocalInt(oUser,"mothdealfacedown")==TRUE)
                {
                    FloatingTextStringOnCreature("<cþ¥ >"+sUser+" Deals a Face-down card to "+sTarget+".</c>", oUser, TRUE);
                    FloatingTextStringOnCreature("<cþ¥ >"+sTarget+" Gets a Face-down card dealt from "+sUser+".</c>", oTarget, TRUE);
                    oCard = CreateItemOnObject("mothcard", oTarget, 1);
                }
                else if(!GetIsPC(oTarget))
                {
                    FloatingTextStringOnCreature("<cþ¥ >You cannot deal a card to "+sTarget+".</c>", oUser, TRUE);
                }
            }
            if(GetIsObjectValid(oCard))
            {
                string suit = "E";
                string face = "E";
                face = GetSubString(card, 0, 1);
                suit = GetSubString(card, 1, 1);
                if(suit=="S") suit = "Spades";
                if(suit=="D") suit = "Diamonds";
                if(suit=="H") suit = "Hearts";
                if(suit=="C") suit = "Clubs";
                if(face=="A") face = "Ace";
                if(face=="K") face = "King";
                if(face=="Q") face = "Queen";
                if(face=="J") face = "Jack";
                if(face=="1") face = "10";
                SetLocalString(oCard, "face", face);
                SetLocalString(oCard, "suit", suit);
                SetLocalInt(oItem, card, 0);
                SetLocalInt(oItem, "numCards", GetLocalInt(oItem, "numCards")-1);
                SetName(oItem, "A Deck of Cards (" + IntToString(GetLocalInt(oItem, "numCards")) + ")");
                if(GetLocalInt(oUser,"mothdealfacedown")==FALSE)
                {
                  DelayCommand(0.1,MothFlipAFaceDownCard(oCard));
                }
            }
            else
            {
            }

        }
        else
        {
            int si = 0;
            string suit = "E";
            for(si = 0; si<4; si++)
            {
                if(si==0) suit = "S";
                if(si==1) suit = "D";
                if(si==2) suit = "H";
                if(si==3) suit = "C";

                SetLocalInt(oItem, ("A" + suit), 1);
                SetLocalInt(oItem, ("K" + suit), 1);
                SetLocalInt(oItem, ("Q" + suit), 1);
                SetLocalInt(oItem, ("J" + suit), 1);
                int fv = 1;
                for(fv = 1; fv < 10; fv++)
                {
                    SetLocalInt(oItem, (IntToString(fv) + suit), 1);
                }
            }
            SetLocalInt(oItem, "initialized", 1);
            SetLocalInt(oItem, "numCards", 52);
            SetName(oItem, "A Full Deck of Cards");
            SetPlotFlag(oItem, TRUE);
            FloatingTextStringOnCreature("<cþ¥ >"+sUser+ " opens a new deck of cards.</c>", oUser, TRUE);
        }
    }
}
