void main()
{
object oPC = GetEnteringObject();
effect eCurse = EffectCurse(DAMAGE_BONUS_2d4, DAMAGE_BONUS_1d4, DAMAGE_BONUS_1d4, DAMAGE_BONUS_1d4,DAMAGE_BONUS_1d4, DAMAGE_BONUS_2d4);
effect eKnock = EffectKnockdown();
string sPC = GetName(oPC);
int nInt;
eCurse = ExtraordinaryEffect(eCurse);
eKnock = ExtraordinaryEffect(eKnock);
if (!GetIsPC(oPC)) return;
nInt=GetLocalInt(oPC, "Cough");
if (nInt >= 5)
   {
   int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
   if (DoOnce==TRUE) return;
   SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
   FloatingTextStringOnCreature("<cýõæ>"+sPC+" collapses from a illness.</c>", oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCurse, oPC, RoundsToSeconds(50));
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oPC, RoundsToSeconds(10));
   }
else
   {
   return;
   }
}
