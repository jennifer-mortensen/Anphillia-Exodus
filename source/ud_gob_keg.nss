void CreateNewItems(object oContainer)
{
   if (GetItemPossessedBy(oContainer, "RotheMeat") == OBJECT_INVALID)
      CreateItemOnObject("rothemeat", oContainer);
   if (GetItemPossessedBy(oContainer, "cnrGarlicClove") == OBJECT_INVALID)
   {
      int nToCreate = Random(3) + 2;
      int nCount;
      for (nCount = 0; nCount < nToCreate; nCount++)
      {
         CreateItemOnObject("cnrgarlicclove", oContainer);
      }
   }
}

void main()
{
   CreateNewItems(GetNearestObjectByTag("GoblinKeg"));
}
