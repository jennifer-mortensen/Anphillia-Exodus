#include "zep_inc_phenos2"
#include "nw_i0_plot"
void main()
{
object oPC = GetPCSpeaker();
object oTarget;
location lTarget;
object oSpawn;
if(GetLocalString(oPC,"MothSetFactionInt")=="MothCleavenMember")
  {
            if ((GetRacialType(oPC)==RACIAL_TYPE_GNOME)||
                (GetRacialType(oPC)==RACIAL_TYPE_HALFLING))
               {
               oTarget = oPC;
               lTarget = GetLocation(oTarget);
               SetLocalInt(oPC,"FirstHorseCall",FALSE);
               oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "mothcleavenpony", lTarget);
               }
            else if ((GetRacialType(oPC)==RACIAL_TYPE_ELF)||
                (GetRacialType(oPC)==RACIAL_TYPE_HALFELF)||
                (GetRacialType(oPC)==RACIAL_TYPE_HALFORC)||
                (GetRacialType(oPC)==RACIAL_TYPE_DWARF)||
                (GetRacialType(oPC)==RACIAL_TYPE_HUMAN))
               {
               oTarget = oPC;
               lTarget = GetLocation(oTarget);
               SetLocalInt(oPC,"FirstHorseCall",FALSE);
               oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "mothcleavenhorse", lTarget);
               }
   }
else
   {
            if ((GetRacialType(oPC)==RACIAL_TYPE_GNOME)||
                (GetRacialType(oPC)==RACIAL_TYPE_HALFLING))
               {
               oTarget = oPC;
               lTarget = GetLocation(oTarget);
               SetLocalInt(oPC,"FirstHorseCall",FALSE);
               oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "mothaxfellpony", lTarget);
               }
            else if ((GetRacialType(oPC)==RACIAL_TYPE_ELF)||
                (GetRacialType(oPC)==RACIAL_TYPE_HALFELF)||
                (GetRacialType(oPC)==RACIAL_TYPE_HALFORC)||
                (GetRacialType(oPC)==RACIAL_TYPE_DWARF)||
                (GetRacialType(oPC)==RACIAL_TYPE_HUMAN))
               {
               oTarget = oPC;
               lTarget = GetLocation(oTarget);
               SetLocalInt(oPC,"FirstHorseCall",FALSE);
               oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "mothhorseaxfell", lTarget);
               }
   }
}

