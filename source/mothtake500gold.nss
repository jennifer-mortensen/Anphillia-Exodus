void main()
{
    object oPC = GetPCSpeaker();
    int nRoll = d20();
    SetLocalInt(oPC,"MothFortune",nRoll);
    TakeGoldFromCreature(500, oPC, TRUE);
}
