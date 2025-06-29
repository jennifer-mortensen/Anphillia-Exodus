void main()
{
    object oPC = GetEnteringObject();
    if(!GetIsPC(oPC))
        return;
    SetLocalInt(oPC, "IS_IN_CELL", TRUE);
}
