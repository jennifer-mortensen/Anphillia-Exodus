int StartingConditional()
{
    int isCleavenRelicStolen;
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    //Checks to see if cleaven relic has been sotlen
    isCleavenRelicStolen = GetLocalInt(oModule, "Relic_Status") != 0 && GetLocalInt(oModule, "Relic_Status") != 1 && GetLocalInt(oModule, "Relic_Status") != 4;
    return isCleavenRelicStolen;
}
