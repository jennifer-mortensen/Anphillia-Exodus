void main()
{
object oMod = GetModule();
int nInt=GetLocalInt(oMod, "Mothpuzz2");
    if (nInt <= 1)
    {
    SetLocked(OBJECT_SELF, TRUE);
    ActionCloseDoor(OBJECT_SELF);
    return;
    }
    if (nInt = 2)
    {
    nInt = 3;
    SetLocalInt(oMod, "Mothpuzz2", nInt);
    DestroyObject(OBJECT_SELF);
    }
}
