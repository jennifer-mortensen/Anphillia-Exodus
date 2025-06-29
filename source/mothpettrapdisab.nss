void main()
{
  object oPC = GetLastDisarmed();
  object oPet = CreateItemOnObject("mothpetbase",oPC);
  string sName;
  switch (Random(15))
         {
          case 0: sName = "Cat"; break;
          case 1: sName = "Dog"; break;
          case 2: sName = "Piglet"; break;
          case 3: sName = "Parrot"; break;
          case 4: sName = "Kitten"; break;
          case 5: sName = "Mouse"; break;
          case 6: sName = "Hen"; break;
          case 7: sName = "Ferret"; break;
          case 8: sName = "Mink"; break;
          case 9: sName = "Monkey"; break;
          case 10: sName = "Penguin"; break;
          case 11: sName = "Raccoon"; break;
          case 12: sName = "Rat"; break;
          case 13: sName = "Skunk"; break;
          case 14: sName = "Snake"; break;
          case 15: sName = "Puppy"; break;
         }
  if(GetIsObjectValid(oPet) && sName != "")
  {
  SetName(oPet,sName);
  SetDescription(oPet,"This is the cage for your pet "+sName+".",TRUE);
  FloatingTextStringOnCreature("<cþ¥ >You rescued a "+sName+" entangled in a trap!</c>", oPC, TRUE);
  }
}
