void main()
{

    object oPC;
    object oTarget;
    int bDestroy=TRUE;

    oPC = GetPCSpeaker();
    TakeGoldFromCreature (100, oPC, bDestroy) ;
    oTarget = GetObjectByTag ("ShipSerisIsland");

    DelayCommand(5.0, AssignCommand(oPC,JumpToObject(oTarget)));
}

