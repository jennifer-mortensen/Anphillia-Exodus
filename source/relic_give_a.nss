//::///////////////////////////////////////////////
//:: FileName relic_give_a
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Kevin Ward
//:: Created On: 4/1/2008 11:09:19 PM
//::
//:: Gives the Cleaven PC both the Axfell Relic and
//:: the Cleaven relic is it has been stolen or just
//:: the Axfell relic if it has not.
//::
//:://////////////////////////////////////////////
void main()
{
    // Check if Cleaven Relic is here, if so, give both axfell and cleaven
    //relic then ipdate the relic status to have both in transit to Cleaven
    if(GetLocalInt(GetModule(), "Relic_Status") == 3)
    {
        CreateItemOnObject("cleavenrelic", GetPCSpeaker(), 1);
        CreateItemOnObject("axfellrelic", GetPCSpeaker(), 1);
        SetLocalInt(GetModule(), "Relic_Status", 5);
        SetCustomToken(900, "<cþþ >In Transit"); // Cleaven yellow is in transit
        SetCustomToken(901, "<cþþ >In Transit"); // Axfell yellow is in transit
    //If just the Axfell Relic is here give it to the PC and update the status
    //to denote that Axfell relic only is in transit to Cleaven
    }else if(GetLocalInt(GetModule(), "Relic_Status") == 0){
        CreateItemOnObject("axfellrelic", GetPCSpeaker(), 1);
        SetLocalInt(GetModule(), "Relic_Status", 1);
        SetCustomToken(901, "<cþþ >In Transit"); // Axfell yellow is in transit
    }
    SetLocalInt(GetModule(), "MOTHAXFRELIC",TRUE);
    object aPC = GetFirstPC();
    while (GetIsObjectValid(aPC))
    {
      SendMessageToPC(aPC, "<c  þ>[Faction] Cleavens have Stolen the Axfell Relic!</c>");
      aPC = GetNextPC();
    }
}
