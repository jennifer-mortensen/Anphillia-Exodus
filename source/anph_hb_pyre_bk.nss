void main()
{
    int nCt=GetLocalInt(OBJECT_SELF,"BURNCOUNT");
    if (nCt > 10)
    {
        DestroyObject (OBJECT_SELF);
    }
    else
    {
        nCt++;
        SetLocalInt(OBJECT_SELF,"BURNCOUNT", nCt+1);
    }
}
