// This script is for existing characters that were allowed to gain xp far beyond their level
// before leveling up

#include "hc_inc"

#include "anph_db_inc"
#include "anph_xp_inc"
#include "anph_level_inc"

int GetIsClassAllowed(object oPC, int iClass_Higher, int iClass_Lower)
{
   switch (iClass_Higher)
   {
   case 1: // couldn't be the higher class anyway
         return FALSE;
      break;
   case 2: // couldn't be the higher class anyway
         return FALSE;
      break;
   case 3:
      if (iClass_Lower == MCE_MONK ||
          iClass_Lower == MCE_PALADIN ||
          iClass_Lower == MCE_WIZARD ||
          iClass_Lower == MCE_SORCERER ||
          iClass_Lower == MCE_ROGUE ||
          iClass_Lower == MCE_BARD ||
          iClass_Lower == MCE_CLERIC)
         return FALSE;
      break;
   case 4:
      if (iClass_Lower == MCE_MONK ||
          iClass_Lower == MCE_PALADIN ||
          iClass_Lower == MCE_RANGER ||
          iClass_Lower == MCE_BARBARIAN ||
          iClass_Lower == MCE_SORCERER)
         return FALSE;
      break;
   case 5: // couldn't be the higher class anyway
         return FALSE;
      break;
   case 6:
      if (iClass_Lower == MCE_MONK ||
          iClass_Lower == MCE_PALADIN ||
          iClass_Lower == MCE_RANGER ||
          iClass_Lower == MCE_SORCERER)
         return FALSE;
      break;
   case 7:
      if (iClass_Lower == MCE_MONK ||
          iClass_Lower == MCE_PALADIN ||
          iClass_Lower == MCE_BARD ||
          iClass_Lower == MCE_ROGUE ||
          iClass_Lower == MCE_WIZARD ||
          iClass_Lower == MCE_SORCERER)
         return FALSE;
      break;
   case 8:
      if (iClass_Lower == MCE_MONK ||
          iClass_Lower == MCE_PALADIN ||
          iClass_Lower == MCE_SORCERER)
         return FALSE;
      break;
   case 9: // couldn't be the higher class anyway
         return FALSE;
      break;
   case 10:
      return FALSE;
      break;
   case 11:
      if (iClass_Lower != MCE_FIGHTER)
         return FALSE;
      break;
   case 12:
      if (iClass_Lower == MCE_MONK ||
          iClass_Lower == MCE_PALADIN||
          iClass_Lower == MCE_WIZARD ||
          iClass_Lower == MCE_SORCERER)
         return FALSE;
      break;
   case 13:
      if (iClass_Lower == MCE_MONK ||
          iClass_Lower == MCE_PALADIN ||
          iClass_Lower == MCE_SORCERER)
         return FALSE;
      break;
   case 14: // couldn't be the higher class anyway
         return FALSE;
      break;
   case 15:
      if (iClass_Lower == MCE_MONK ||
          iClass_Lower == MCE_PALADIN ||
          iClass_Lower == MCE_FIGHTER ||
          iClass_Lower == MCE_WIZARD ||
          iClass_Lower == MCE_CLERIC ||
          iClass_Lower == MCE_DRUID)
         return FALSE;
      break;
   case 16:
      if (iClass_Lower == MCE_MONK ||
          iClass_Lower == MCE_PALADIN ||
          iClass_Lower == MCE_SORCERER ||
          iClass_Lower == MCE_RANGER ||
          iClass_Lower == MCE_DRUID)
         return FALSE;
      break;
   }
   return TRUE;
}

int IsAllowedToMulticlass(object oPC)
{
   int iClass;
   int iClassNew;
   int iCurrentClassLevel = 0;
   int iNewClassLevel = 0;
   int iNumberOfClassesFound = 0;
   int iAllowed = FALSE;
   int iClassMatch;
   string sClassToCheck;
   for (iClass = 1; iClass < 17; iClass++)      // go through all classes
   {
      iNumberOfClassesFound = 0;
      iCurrentClassLevel = GetLocalInt(oPC, "Class" + ConvertNumberToFixedString(iClass));
      if (iCurrentClassLevel > 0)               // when a class has a level > 1
      {
          // SendMessageToAllDMs(GetName(oPC) + " has " + IntToString(iCurrentClassLevel) + " Levels in Class #" + IntToString(iClass) + ".");
          for (iClassNew = 1; iClassNew < 17; iClassNew++)      // go through all classes to see if there is another one
          {
             if (iClassNew != iClass)
             {
                iNewClassLevel = GetLocalInt(oPC, "Class" + ConvertNumberToFixedString(iClassNew));
                if (iNewClassLevel > 0)
                   {
                      // SendMessageToAllDMs(GetName(oPC) + " has " + IntToString(iNewClassLevel) + " Levels in Multi-Class #" + IntToString(iClassNew) + ".");
                      iNumberOfClassesFound++;
                      if ((iCurrentClassLevel > (MIN_LEVEL_IN_ONE_CLASS - 1) &&
                           iCurrentClassLevel < (MAX_LEVEL_IN_ONE_CLASS + 1)) ||
                          (iNewClassLevel > (MIN_LEVEL_IN_ONE_CLASS - 1) &&
                           iNewClassLevel < (MAX_LEVEL_IN_ONE_CLASS + 1)))
                      {
                         if (iCurrentClassLevel > iNewClassLevel)
                            iClassMatch = GetIsClassAllowed(oPC, iClass, iClassNew);
                         else
                            iClassMatch = GetIsClassAllowed(oPC, iClassNew, iClass);

                         if (iNumberOfClassesFound < (ALLOWED_CLASSES) &&
                             iClassMatch)
                         {
                            iAllowed = TRUE;      // is allowed to multi-class
                         }
                         else
                         {
                            return FALSE;
                         }
                      }
                      else
                      {
                         return FALSE;      // is not allowed to multi-class
                      }
                   }
              }
          }
      }
   }
   return TRUE;
}

void main()
{
   object oPC = GetPCLevellingUp();
   string sMessage;
   int iHD = GetHitDice(oPC);

   if (iHD < 2)
      return;

// DEBUG
//   SendMessageToAllDMs("Reported Level: " + IntToString(iHD));
// DEBUG END

   // retrieve all PC Levels
   SaveLevelsOnPC(oPC);

   int iLevelXP;
   /* if (iHD < 20)
   {
      iLevelXP = GetLevelExp(iHD) + 1;
      SetXP(oPC, iLevelXP);
   } */
   if (!ALLOW_PRESTIGE_CLASSES)
   {
      if (GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, oPC) > 0 ||
          GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) > 0 ||
          GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) > 0 ||
          GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC) > 0 ||
          GetLevelByClass(CLASS_TYPE_HARPER, oPC) > 0)
      {
         iLevelXP = GetHitDice(oPC) - 1;
         SendMessageToPC(oPC, "You are not allowed to level-up in a Prestige Class on this server.");
         SetXP(oPC, iLevelXP);
         DeleteLevelsOnPC(oPC);
         return;
      }
   }


   if (APPLY_MULTICLASSING_RULES)
   {
      if (!IsAllowedToMulticlass(oPC))
      {
         iLevelXP = GetHitDice(oPC) - 1;
         SendMessageToPC(oPC, "Read the rules about multiclassing.");
         sMessage = GetName(oPC) + " was not allowed to multi-class and his XP were set back to " + IntToString(iLevelXP);
         SetXP(oPC, iLevelXP);
         DeleteLevelsOnPC(oPC);
         return;
      }
   }
   sMessage = CreateLevelUpMessage(oPC);
   DeleteLevelsOnPC(oPC);
}
