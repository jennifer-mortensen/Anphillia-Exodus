void main()
{
    object oPC = GetExitingObject();
    if(!GetIsPC(oPC))
        return;
    DeleteLocalInt(oPC, "IS_IN_CELL");
}
