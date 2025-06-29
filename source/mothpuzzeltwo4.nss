void main()
{
object oMod = GetModule();
int nInt=GetLocalInt(oMod, "Mothpuzz2");
    if (nInt <= 2)
    {
    SetLocked(OBJECT_SELF, TRUE);
    ActionCloseDoor(OBJECT_SELF);
    return;
    }
    if (nInt = 3)
    {
    nInt = 4;
    SetLocalInt(oMod, "Mothpuzz2", nInt);
    DestroyObject(OBJECT_SELF);
    }
}
