int StartingConditional()
{
    int isAxfellRelicStolen;
    object oModule = GetModule();

    //Checks to see if cleaven relic has been sotlen
    isAxfellRelicStolen = GetLocalInt(oModule, "Relic_Status") != 0 && GetLocalInt(oModule, "Relic_Status") != 2 && GetLocalInt(oModule, "Relic_Status") != 3;
    return isAxfellRelicStolen;
}
