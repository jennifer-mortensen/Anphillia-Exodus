void main()
{
    object oPortcullis = GetObjectByTag("ironhold_Portcullis");
    object oDoor = GetObjectByTag("ironhold_GateToMine");

    ActionOpenDoor(oDoor);
    DelayCommand(4.0, ActionCloseDoor(oPortcullis));


}
