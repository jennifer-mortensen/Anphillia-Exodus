#include "moth_inc_effects"
void main()
{
object oPC = GetPCSpeaker();
if (GetRacialType(oPC)==RACIAL_TYPE_HUMAN)
   {
   SetSubRace(oPC, "tiefling");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_ELF)
   {
   SetSubRace(oPC, "moon-elf");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_HALFORC)
   {
   SetSubRace(oPC, "half-orge");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_DWARF)
   {
   SetSubRace(oPC, "dwarf-shield");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_HALFLING)
   {
   SetSubRace(oPC, "furchin");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_HALFELF)
   {
   SetSubRace(oPC, "half-moon");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_GNOME)
   {
   SetSubRace(oPC, "forest-gnome");
   }
   FloatingTextStringOnCreature("<cðøþ>*SUBRACE SET*</c>",oPC);
   MothBonuses(oPC);
}
