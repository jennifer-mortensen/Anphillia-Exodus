void main()
{
object oMod = GetModule();
int nInt=GetLocalInt(oMod, "Mothpuzz2");
    if (nInt <= 3)
    {
    SetLocked(OBJECT_SELF, TRUE);
    ActionCloseDoor(OBJECT_SELF);
    return;
    }
    if (nInt = 4)
    {
    nInt = 5;
    SetLocalInt(oMod, "Mothpuzz2", nInt);
    DestroyObject(OBJECT_SELF);
    }
}
