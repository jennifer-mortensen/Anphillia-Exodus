int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return (GetGold(oPC) >= 50000);
}
