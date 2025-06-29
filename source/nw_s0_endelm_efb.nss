void main()
{
    object oCaster = GetAreaOfEffectCreator();
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
}
