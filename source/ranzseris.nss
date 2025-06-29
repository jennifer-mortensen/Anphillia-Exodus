void main()
{
    object oPC;
    object oTarget;
    oPC = GetPCSpeaker();

    oTarget = GetObjectByTag("ShipSerisIsland");
    DelayCommand(5.0, AssignCommand(oPC,JumpToObject(oTarget)));
}
