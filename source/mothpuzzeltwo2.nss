void main()
{
object oMod = GetModule();
int nInt=GetLocalInt(oMod, "Mothpuzz2");
    if(nInt = 0)
    {
    SetLocked(OBJECT_SELF, TRUE);
    ActionCloseDoor(OBJECT_SELF);
    return;
    }
    if(nInt = 1)
    {
    nInt = 2;
    SetLocalInt(oMod, "Mothpuzz2", nInt);
    DestroyObject(OBJECT_SELF);
    }
}
