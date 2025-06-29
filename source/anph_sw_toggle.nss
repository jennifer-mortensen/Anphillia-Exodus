void main()
{
    int nValue;
    int nNeeded;
    object oAltar;
    object oPC = GetLastUsedBy ();

    if (GetLocalInt (OBJECT_SELF, "toggling"))
        return;

    SetLocalInt (OBJECT_SELF, "toggling", 1);
    DelayCommand (2.0, DeleteLocalInt (OBJECT_SELF, "toggling"));


    nValue = GetLocalInt (OBJECT_SELF, "value");
    if (nValue == 0)
    {
        nValue = 1;
        AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }
    else
    {
        AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        nValue = 0;
    }

    SetLocalInt (OBJECT_SELF, "value", nValue);

    oAltar = GetObjectByTag ("InsaneMageAltar");
    nNeeded = GetLocalInt (oAltar, "NeededNumber");
    if (nNeeded == 0)
        return;

    object s1 = GetObjectByTag ("InsaneMageSwitch1");
    object s2 = GetObjectByTag ("InsaneMageSwitch2");
    object s3 = GetObjectByTag ("InsaneMageSwitch3");
    object s4 = GetObjectByTag ("InsaneMageSwitch4");

    int nCurval = GetLocalInt (s4, "value");
    nCurval += (GetLocalInt (s3, "value") * 2);
    nCurval += (GetLocalInt (s2, "value") * 4);
    nCurval += (GetLocalInt (s1, "value") * 8);

    object oDoor = GetObjectByTag ("InsaneMageDoor");

    if (nCurval == nNeeded)
    {
        SetLocked (oDoor, FALSE);
        DelayCommand(300.0, SetLocked(oDoor, TRUE));
        DelayCommand(300.0, DeleteLocalInt (oAltar, "NeededNumber"));
        FloatingTextStringOnCreature ("You hear a faint clink sound", oPC);
    }
    else
    {
        SetLocked (oDoor, TRUE);
    }

}
