void main()
{
    object oItem = GetFirstItemInInventory(OBJECT_SELF);
    if(!GetIsObjectValid(oItem))
        DestroyObject(OBJECT_SELF);
}
