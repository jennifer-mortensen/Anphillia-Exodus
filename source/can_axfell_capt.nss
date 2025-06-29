int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    //Checks if the Axfell Relic has been stolen, the plaeyr has it and the player is a Cleaven
    // OR if a Axfell is returning the Cleaven Relic with the axefell relic
    iResult = GetLocalInt(oModule, "Relic_Status") == 2 && (GetIsObjectValid(GetItemPossessedBy(oPC, "axfellwarriorrin"))) && (GetIsObjectValid(GetItemPossessedBy(oPC, "cleavenrelic")));
    iResult = iResult || (GetLocalInt(oModule, "Relic_Status") == 6 && (GetIsObjectValid(GetItemPossessedBy(oPC, "axfellwarriorrin"))) && (GetIsObjectValid(GetItemPossessedBy(oPC, "cleavenrelic"))) && (GetIsObjectValid(GetItemPossessedBy(oPC, "axfellrelic"))));
    return iResult;
}
