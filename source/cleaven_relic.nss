int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    object oModule = GetModule();
    //Checks IF just the cleaven relic is here or both the cleaven and axfell relic is here
    //and if the PC is an Axfell character
    iResult = (GetLocalInt(oModule, "Relic_Status") == 0 || GetLocalInt(oModule, "Relic_Status") == 4) && (GetLocalString(oPC,"MothSetFactionInt") == "MothAxfellMember");
    return iResult;
}
