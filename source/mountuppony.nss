#include "zep_inc_phenos2"
#include "x0_i0_spells"
#include "x3_inc_horse"
void main()
{
object oPC = GetLastSpeaker();
string sDeny;
if (!GetIsPC(oPC)) return;
if(HorseGetIsMounted(oPC)== TRUE)
    {
        SendMessageToPC(oPC,"<cеее>[Server] You cannot ride two horses at once!</c>");
        return ;
    }
if(GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT))
   {
    SendMessageToPC(oPC,"<cеее>[Server] You cannot mount with this spell active.</c>");
    return;
   }
if(GetHasEffect(EFFECT_TYPE_POLYMORPH,oPC))
   {
    SendMessageToPC(oPC,"<cеее>[Server] You cannot mount while polymorphed.</c>");
    return;
   }
if ((GetRacialType(oPC)!=RACIAL_TYPE_GNOME)&&
    (GetRacialType(oPC)!=RACIAL_TYPE_HALFLING))
   {
   sDeny="<cеее>[Server] You are too tall to ride a pony. Try a horse instead.</c>";
   SendMessageToPC(oPC, sDeny);
   return;
   }
if (!GetIsPC(oPC)) return;
if (GetItemPossessedBy(oPC, "horsetoken")== OBJECT_INVALID)
   {
   SendMessageToPC(oPC, "<cеее>[Server] You do not have permission to ride this animal.</c>");
   return;
   }
zep_Mount(oPC, OBJECT_SELF);
SetLocalInt(oPC,"HasMount",TRUE);
SetLocalInt(oPC,"HasMountExp",TRUE);
}
