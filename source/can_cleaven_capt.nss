int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    //Checks if the Axfell Relic has been stolen, the plaeyr has it and the player is a Cleaven
    // OR if a Cleaven is returning the Cleaven Relic with the axefell relic
    iResult = GetLocalInt(oModule, "Relic_Status") == 1 && (GetIsObjectValid(GetItemPossessedBy(oPC, "cleavenmilitiari"))) && (GetIsObjectValid(GetItemPossessedBy(oPC, "axfellrelic")));
    iResult = iResult || (GetLocalInt(oModule, "Relic_Status") == 5 && (GetIsObjectValid(GetItemPossessedBy(oPC, "cleavenmilitiari"))) && (GetIsObjectValid(GetItemPossessedBy(oPC, "cleavenrelic"))) && (GetIsObjectValid(GetItemPossessedBy(oPC, "axfellrelic"))));
    return iResult;
}

