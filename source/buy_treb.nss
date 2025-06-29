void main()
{
    object oPC = GetPCSpeaker();
    if(GetGold(oPC) >= 50000)
    {
        TakeGoldFromCreature(50000, oPC, TRUE);
        CreateItemOnObject("trebuchet", oPC, 1, "trebuchetItem");
    }
}
