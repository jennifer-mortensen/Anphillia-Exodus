void main()
{
    object oGlyph = GetAreaOfEffectCreator(OBJECT_SELF);
    object oCaster = GetLocalObject(oGlyph, "oCaster");

    if (!GetIsObjectValid(oGlyph) || !GetIsObjectValid(oCaster)) // the placeable or creator is no longer there
    {
        DestroyObject(OBJECT_SELF);
    }
}
