//::///////////////////////////////////////////////
//:: FileName cleaven_capture
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Kevin
//:: Created On: 4/3/2008 7:50:22 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();
    object aRelic = GetItemPossessedBy(oPC, "axfellrelic");
    object cRelic = GetItemPossessedBy(oPC, "cleavenrelic");

    //Destroy the relics from the PC's inventory
    if(GetIsObjectValid(aRelic)){ DestroyObject(aRelic); }
    if(GetIsObjectValid(cRelic)){ DestroyObject(cRelic); }

    //Set the Relic Status to Cleaven Captured
    SetLocalInt(GetModule(), "Relic_Status", 4);
    SetCustomToken(901, "<cþ  >Stolen"); // Axfell red is stolen
    SetCustomToken(900, "<c þ >Safe"); // Cleaven green is safe
    DeleteLocalInt(GetModule(), "MOTHAXFRELIC");
    object aPC = GetFirstPC();
    while (GetIsObjectValid(aPC))
    {
      SendMessageToPC(aPC, "<c  þ>[Faction] Cleaven has Captured the Axfell Relic!</c>");
      aPC = GetNextPC();
    }



}
