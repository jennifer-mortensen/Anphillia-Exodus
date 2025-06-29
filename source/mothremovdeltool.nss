void main()
{
    object oPC = GetPCSpeaker();
    object oTake1 = GetItemPossessedBy(oPC,"mothremoveplot");
    if(GetIsObjectValid(oTake1))
      {
        DestroyObject(oTake1);
      }
}
