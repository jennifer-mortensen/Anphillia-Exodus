//::///////////////////////////////////////////////
//:: FileName relic_give_c
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Kevin Ward
//:: Created On: 4/1/2008 11:09:19 PM
//::
//:: Gives the Axfell PC both the Cleaven Relic and
//:: the Axfell relic is it has been stolen or just
//:: the cleaven relic if it has not.
//::
//:://////////////////////////////////////////////
void main()
{
    // Check if Axfell Relic is here, if so, give both axfell and cleaven
    //relic then Update the relic status to have both in transit to Axfell
    if(GetLocalInt(GetModule(), "Relic_Status") == 4)
    {
        CreateItemOnObject("cleavenrelic", GetPCSpeaker(), 1);
        CreateItemOnObject("axfellrelic", GetPCSpeaker(), 1);
        SetLocalInt(GetModule(), "Relic_Status", 6);
        SetCustomToken(900, "<cþþ >In Transit"); // Cleaven yellow is in transit
        SetCustomToken(901, "<cþþ >In Transit"); // Axfell yellow is in transit
    //If just the cleaven Relic is here give it to the PC and update the status
    //To denote that cleaven relic only is in transit to Axfell
    }else if(GetLocalInt(GetModule(), "Relic_Status") == 0){
        CreateItemOnObject("cleavenrelic", GetPCSpeaker(), 1);
        SetLocalInt(GetModule(), "Relic_Status", 2);
        SetCustomToken(900, "<cþþ >In Transit"); // Cleaven yellow is in transit
    }
    SetLocalInt(GetModule(), "MOTHCLVRELIC",TRUE);
    object aPC = GetFirstPC();
    while (GetIsObjectValid(aPC))
    {
      SendMessageToPC(aPC, "<c  þ>[Faction] Axfells have Stolen the Cleaven Relic!</c>");
      aPC = GetNextPC();
    }
}
