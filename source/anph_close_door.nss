//#include "moth_inc"
void main()
{
    float fDoorCloseDelay = GetLocalFloat(OBJECT_SELF, "DOOR_CLOSE_DELAY");
    if(fDoorCloseDelay == 0.0)
        return;
    DelayCommand(fDoorCloseDelay, ActionCloseDoor(OBJECT_SELF));
}

