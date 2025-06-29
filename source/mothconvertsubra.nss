#include "moth_inc_effects"
void main()
{
object oPC = GetPCSpeaker();
if (GetRacialType(oPC)==RACIAL_TYPE_HUMAN)
   {
   SetSubRace(oPC, "aasimar");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_ELF)
   {
   SetSubRace(oPC, "dark-elf");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_HALFORC)
   {
   SetSubRace(oPC, "orc");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_DWARF)
   {
   SetSubRace(oPC, "dwarf-duergar");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_HALFLING)
   {
   SetSubRace(oPC, "ghostwise");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_HALFELF)
   {
   SetSubRace(oPC, "half-drow");
   }
else if(GetRacialType(oPC)==RACIAL_TYPE_GNOME)
   {
   SetSubRace(oPC, "svirfneblin");
   }
   FloatingTextStringOnCreature("<cðøþ>*SUBRACE SET*</c>",oPC);
   MothBonuses(oPC);
}
