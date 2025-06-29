void main()
{
    if(GetLocalInt(OBJECT_SELF, "TEST_CLOSEDOOR_CHANGE") == 0){
        SetLocalInt(OBJECT_SELF, "TEST_CLOSEDOOR_CHANGE", 1);
       //WriteTimestampedLogEntry("SCRIPT_FIXING: Door " + GetTag(OBJECT_SELF) + " in area " + GetName(GetArea(OBJECT_SELF)) + " needs to be changed to NORMAL close with dz_close_door");
    }
    ExecuteScript("dz_close_chest", OBJECT_SELF);
}

