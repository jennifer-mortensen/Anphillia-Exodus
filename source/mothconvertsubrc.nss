#include "moth_inc_effects"
void main()
{
object oPC = GetPCSpeaker();
if (GetRacialType(oPC)==RACIAL_TYPE_HUMAN)
   {
   SetSubRace(oPC, "");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_ELF)
   {
   SetSubRace(oPC, "");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_HALFORC)
   {
   SetSubRace(oPC, "half-troll");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_DWARF)
   {
   SetSubRace(oPC, "");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_HALFLING)
   {
   SetSubRace(oPC, "");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_HALFELF)
   {
   SetSubRace(oPC, "");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_GNOME)
   {
   SetSubRace(oPC, "");
   }
   FloatingTextStringOnCreature("<cðøþ>*SUBRACE SET*</c>",oPC);
   MothBonuses(oPC);
}
