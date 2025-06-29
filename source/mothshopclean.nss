void main()
{
   object oObject = GetFirstItemInInventory();
   while (GetIsObjectValid(oObject) == TRUE)
   {
      DestroyObject(oObject);
      oObject = GetNextItemInInventory();
   }

}

