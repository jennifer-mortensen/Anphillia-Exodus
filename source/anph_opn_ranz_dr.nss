void main()
{
    object oGate;
    oGate = GetObjectByTag ("RanzingtonCityDoor");
    SetLocked (oGate, FALSE);
    ActionOpenDoor (oGate);
}
