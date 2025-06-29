// Config
int ALLOW_PRESTIGE_CLASSES = FALSE;
int APPLY_MULTICLASSING_RULES = TRUE;
int MIN_LEVEL_IN_ONE_CLASS = 11;
int MAX_LEVEL_IN_ONE_CLASS = 15;
int ALLOWED_CLASSES = 2;

// CLASS DEFINITIONS
int MCE_ARCANEARCHER = 1;
int MCE_ASSASSIN = 2;
int MCE_BARBARIAN = 3;
int MCE_BARD = 4;
int MCE_BLACKGUARD = 5;
int MCE_CLERIC = 6;
int MCE_DRUID = 7;
int MCE_FIGHTER = 8;
int MCE_HARPER = 9;
int MCE_MONK = 10;
int MCE_PALADIN = 11;
int MCE_RANGER = 12;
int MCE_ROGUE = 13;
int MCE_SHADOWDANCER = 14;
int MCE_SORCERER = 15;
int MCE_WIZARD = 16;

string ConvertNumberToFixedString(int iNumber)
{
   string sNew;
   if (iNumber < 10)
   {
      sNew = "0" + IntToString(iNumber);
   }
   else
   {
      sNew = IntToString(iNumber);
   }
   return sNew;
}


string GetRace(int iRaceType)
{
  switch ( iRaceType )
  {
     case RACIAL_TYPE_DWARF   : return("Dwarf"   ); break;
     case RACIAL_TYPE_ELF     : return("Elf"     ); break;
     case RACIAL_TYPE_GNOME   : return("Gnome"   ); break;
     case RACIAL_TYPE_HALFELF : return("Halfelf" ); break;
     case RACIAL_TYPE_HALFLING: return("Halfling"); break;
     case RACIAL_TYPE_HALFORC : return("Halforc" ); break;
     case RACIAL_TYPE_HUMAN   : return("Human"   ); break;
     default                  : break;
  }
 return("Unknown");
}

string GetClass( object oPC )
{
  string sClass;

    sClass = "";

    if ( GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) > 0 ) sClass = sClass + "Barbarian." ;
    if ( GetLevelByClass(CLASS_TYPE_BARD     , oPC) > 0 ) sClass = sClass + "Bard."      ;
    if ( GetLevelByClass(CLASS_TYPE_CLERIC   , oPC) > 0 ) sClass = sClass + "Cleric."    ;
    if ( GetLevelByClass(CLASS_TYPE_DRUID    , oPC) > 0 ) sClass = sClass + "Druid."     ;
    if ( GetLevelByClass(CLASS_TYPE_FIGHTER  , oPC) > 0 ) sClass = sClass + "Fighter."   ;
    if ( GetLevelByClass(CLASS_TYPE_MONK     , oPC) > 0 ) sClass = sClass + "Monk."      ;
    if ( GetLevelByClass(CLASS_TYPE_PALADIN  , oPC) > 0 ) sClass = sClass + "Paladin."   ;
    if ( GetLevelByClass(CLASS_TYPE_RANGER   , oPC) > 0 ) sClass = sClass + "Ranger."    ;
    if ( GetLevelByClass(CLASS_TYPE_ROGUE    , oPC) > 0 ) sClass = sClass + "Rogue."     ;
    if ( GetLevelByClass(CLASS_TYPE_SORCERER , oPC) > 0 ) sClass = sClass + "Sorcerer."  ;
    if ( GetLevelByClass(CLASS_TYPE_WIZARD   , oPC) > 0 ) sClass = sClass + "Wizard."    ;

 return(sClass);
}

string GetClassName(int iClassInt)
{
   switch (iClassInt)
   {
   case 1: return ("Arcane Archer");
      break;
   case 2: return ("Assassin");
      break;
   case 3: return ("Barbarian");
      break;
   case 4: return ("Bard");
      break;
   case 5: return ("Blackguard");
      break;
   case 6: return ("Cleric");
      break;
   case 7: return ("Druid");
      break;
   case 8: return ("Fighter");
      break;
   case 9: return ("Harper");
      break;
   case 10: return ("Monk");
      break;
   case 11: return ("Paladin");
      break;
   case 12: return ("Ranger");
      break;
   case 13: return ("Rogue");
      break;
   case 14: return ("Shadowdancer");
      break;
   case 15: return ("Sorcerer");
      break;
   case 16: return ("Wizard");
      break;
   }
   return ("Unknown Class");
}

string CreateLevelUpMessage(object oPC, int iOnJoin = FALSE)
{
   string sCreated;
   int iClassCount;
   int iClassesFound = 0;
   int iCurrentClassLevel;
   if (!iOnJoin)
      sCreated = GetName(oPC) + " just leveled up and is now ";
   for (iClassCount = 1; iClassCount < 17; iClassCount++)
   {
      // enumerate all classes
      iCurrentClassLevel = GetLocalInt(oPC, "Class" + ConvertNumberToFixedString(iClassCount));
      if (iCurrentClassLevel > 0)
      {
         iClassesFound++;
         if (iClassesFound < 2)
         {
            sCreated = sCreated + GetClassName(iClassCount) + " " + IntToString(iCurrentClassLevel);
         }
         else
         {
            sCreated = sCreated + "/" + GetClassName(iClassCount) + " " + IntToString(iCurrentClassLevel);
         }
      }
   }

   if (!iOnJoin)
      sCreated = sCreated + ". XP: " + IntToString(GetXP(oPC));

   return sCreated;
}

void SaveLevelsOnPC(object oPC)
{
   SetLocalInt(oPC, "Class01", GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, oPC));
   SetLocalInt(oPC, "Class02", GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC));
   SetLocalInt(oPC, "Class03", GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC));
   SetLocalInt(oPC, "Class04", GetLevelByClass(CLASS_TYPE_BARD, oPC));
   SetLocalInt(oPC, "Class05", GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC));
   SetLocalInt(oPC, "Class06", GetLevelByClass(CLASS_TYPE_CLERIC, oPC));
   SetLocalInt(oPC, "Class07", GetLevelByClass(CLASS_TYPE_DRUID, oPC));
   SetLocalInt(oPC, "Class08", GetLevelByClass(CLASS_TYPE_FIGHTER, oPC));
   SetLocalInt(oPC, "Class09", GetLevelByClass(CLASS_TYPE_HARPER, oPC));
   SetLocalInt(oPC, "Class10", GetLevelByClass(CLASS_TYPE_MONK, oPC));
   SetLocalInt(oPC, "Class11", GetLevelByClass(CLASS_TYPE_PALADIN, oPC));
   SetLocalInt(oPC, "Class12", GetLevelByClass(CLASS_TYPE_RANGER, oPC));
   SetLocalInt(oPC, "Class13", GetLevelByClass(CLASS_TYPE_ROGUE, oPC));
   SetLocalInt(oPC, "Class14", GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC));
   SetLocalInt(oPC, "Class15", GetLevelByClass(CLASS_TYPE_SORCERER, oPC));
   SetLocalInt(oPC, "Class16", GetLevelByClass(CLASS_TYPE_WIZARD, oPC));
}

void DeleteLevelsOnPC(object oPC)
{
   DeleteLocalInt(oPC, "Class01");
   DeleteLocalInt(oPC, "Class02");
   DeleteLocalInt(oPC, "Class03");
   DeleteLocalInt(oPC, "Class04");
   DeleteLocalInt(oPC, "Class05");
   DeleteLocalInt(oPC, "Class06");
   DeleteLocalInt(oPC, "Class07");
   DeleteLocalInt(oPC, "Class08");
   DeleteLocalInt(oPC, "Class09");
   DeleteLocalInt(oPC, "Class10");
   DeleteLocalInt(oPC, "Class11");
   DeleteLocalInt(oPC, "Class12");
   DeleteLocalInt(oPC, "Class13");
   DeleteLocalInt(oPC, "Class14");
   DeleteLocalInt(oPC, "Class15");
   DeleteLocalInt(oPC, "Class16");
}
