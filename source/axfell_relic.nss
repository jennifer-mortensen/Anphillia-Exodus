int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    object oModule = GetModule();
    //Checks IF just the axfell relic is here or both the cleaven and axefell relic is here
    //and if the PC is an Cleaven character
    iResult = (GetLocalInt(oModule, "Relic_Status") == 0 || GetLocalInt(oModule, "Relic_Status") == 3) && (GetLocalString(oPC,"MothSetFactionInt") == "MothCleavenMember");
    return iResult;
}
