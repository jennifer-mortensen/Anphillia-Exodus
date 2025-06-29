// Changed Pray script, when praying near a level-up statue and having next-level minus 1 xp
// players gain 2 xp and can level

#include "hc_inc"

#include "anph_inc"
#include "anph_db_inc"
#include "anph_xp_inc"
void main()
{
   object oPC=GetLastSpeaker();
   string sFaction = AnphGetPlayerTeam (oPC);
   effect eLevelUp;
   int iHD = GetHitDice(oPC);
   int iLevelXP = GetHitDice(oPC) - 1;
   object oStatue = GetNearestObjectByTag ("LevelStatue", oPC);
   float fDistance = 0.0;
   object oElemAltar = GetNearestObjectByTag ("ElementalAltar", oPC);
   AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_MEDITATE, 1.0, 1000.0));

   /*if (oStatue != OBJECT_INVALID)
   {
      if (FindSubString(GetName(oStatue), sFaction) != -1)
      {
         fDistance = GetDistanceBetween(oPC, oStatue);
         if (fDistance < 7.5)
         {
            if (GetXP(oPC) == iLevelXP)
            {
               if (sFaction == "Cleaven" ||
                   sFaction == "Ranzington")
               {
                  eLevelUp = EffectVisualEffect(VFX_IMP_HOLY_AID);
               }
               else
               {
                  eLevelUp = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
               }
               DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLevelUp, oPC));
               DelayCommand(1.5, SendMessageToPC(oPC, "You are deemed worthy by your ancestors."));
               DelayCommand(1.5, GiveXPToCreature(oPC, 2));
            }
            else
            {
               SendMessageToPC(oPC, "You are not deemed worthy to progess in power, yet.");
            }
         }
      }
   }*/
   if (oElemAltar != OBJECT_INVALID)
   {
      fDistance = GetDistanceBetween(oPC, oElemAltar);
      if (fDistance < 5.0)
      {
         string sAltarName = GetName(oElemAltar);
      }
   }
}
