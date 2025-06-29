#include "_inc_faction"

void main()
{
    object oPC = GetPCSpeaker();
    object oAxfell = GetObjectByTag("MOTHAXFELLHOLDER");
    object oCleaven = GetObjectByTag("MOTHCLEAVENHOLDER");
    object oAxfell2 = GetObjectByTag("MOTHAXFELL2HOLDER");
    object oCleaven2 = GetObjectByTag("MOTHCLEAVEN2HOLDER");
    object oRanzington = GetObjectByTag("MOTHRANZHOLDER");
    object oMerchant = GetObjectByTag("MOTHMERCHOLDER");
    object oDrow = GetObjectByTag("MOTHDROWHOLDER");
    object oAllundra = GetObjectByTag("MOTHALLUHOLDER");
    object oFriendlies = GetObjectByTag("MOTHFRIENDHOLDER");
    object oHostile = GetObjectByTag("MOTHHOSTILEHOLDER");
    object oCommoner = GetObjectByTag("MOTHCOMHOLDER");
    object oDefender = GetObjectByTag("MOTHDEFHOLDER");
    object oLamir = GetObjectByTag("MOTHLAMIRHOLDER");
    string sPlayer;
    string sPlayerCD;
    if(GetIsOfFaction(oPC, FACTION_AXFELL))
    {
     AdjustReputation(oPC,oAxfell2,100);
     AdjustReputation(oPC,oAxfell,100);
     AdjustReputation(oPC,oCleaven2,-100);
     AdjustReputation(oPC,oCleaven,-100);
     AdjustReputation(oPC,oRanzington,100);
     AdjustReputation(oPC,oMerchant,100);
     AdjustReputation(oPC,oAllundra,100);
     AdjustReputation(oPC,oFriendlies,100);
     AdjustReputation(oPC,oCommoner,100);
     AdjustReputation(oPC,oDefender,100);
     AdjustReputation(oPC,oLamir,100);
     AdjustReputation(oPC,oDrow,-100);
     AdjustReputation(oPC,oHostile,-100);
     sPlayer = GetName(oPC);
     sPlayerCD = GetPCPublicCDKey(oPC);
     WriteTimestampedLogEntry("Player "+sPlayer+" with CD Key "+sPlayerCD+" has reset his/her Faction Reputation");
     SendMessageToPC(oPC, "<cþÞ >Your Reputation to ALL Factions have now been reset. This action has been logged!*</c>");
    }
    if(GetIsOfFaction(oPC, FACTION_CLEAVEN))
    {
     AdjustReputation(oPC,oAxfell2,-100);
     AdjustReputation(oPC,oAxfell,-100);
     AdjustReputation(oPC,oCleaven2,100);
     AdjustReputation(oPC,oCleaven,100);
     AdjustReputation(oPC,oRanzington,100);
     AdjustReputation(oPC,oMerchant,100);
     AdjustReputation(oPC,oAllundra,100);
     AdjustReputation(oPC,oFriendlies,100);
     AdjustReputation(oPC,oCommoner,100);
     AdjustReputation(oPC,oDefender,100);
     AdjustReputation(oPC,oLamir,100);
     AdjustReputation(oPC,oDrow,-100);
     AdjustReputation(oPC,oHostile,-100);
     sPlayer = GetName(oPC);
     sPlayerCD = GetPCPublicCDKey(oPC);
     WriteTimestampedLogEntry("Player "+sPlayer+" with CD Key "+sPlayerCD+" has reset his/her Faction Reputation");
     SendMessageToPC(oPC, "<cþÞ >Your Reputation to ALL Factions have now been reset. This action has been logged!*</c>");
    }
    else return;
}
