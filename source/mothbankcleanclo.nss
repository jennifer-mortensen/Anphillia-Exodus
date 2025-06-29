void main()
{
   object oObject = GetFirstItemInInventory();
   while (GetIsObjectValid(oObject) == TRUE)
   {
      if(GetTag(oObject)!="BankToken")
      {
      DestroyObject(oObject);
      }
     oObject = GetNextItemInInventory();
   }
}

