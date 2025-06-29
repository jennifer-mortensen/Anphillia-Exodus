void main()
{
    object oPortcullis = GetObjectByTag("ironhold_Portcullis");
    object oDoor = GetObjectByTag("ironhold_GateToMine");


    ActionOpenDoor(oPortcullis);
    DelayCommand(4.0,ActionCloseDoor(oDoor));
}
