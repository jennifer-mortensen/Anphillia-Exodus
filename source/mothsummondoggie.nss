#include "x2_inc_spellhook"
void main()
{
object oPC;
oPC = GetItemActivator();
if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}
int nAlign = GetAlignmentGoodEvil(oPC);
object oTarget;
int nGen = GetGender(oPC);
MothUnsummonMultipleSummons();
effect eEffect;

if(GetGender(oPC) == GENDER_MALE)
switch (nAlign)
{
   {
     case ALIGNMENT_EVIL:
         {
           eEffect = EffectSummonCreature("mothsummondog1",VFX_NONE);
         }
     break;
     case ALIGNMENT_GOOD:
         {
           eEffect = EffectSummonCreature("mothsummondog",VFX_NONE);
         }
     break;
     case ALIGNMENT_NEUTRAL:
         {
           eEffect = EffectSummonCreature("mothsummondog",VFX_NONE);
         }
     break;
   }
  }
else
switch (nAlign)
{
   {
     case ALIGNMENT_EVIL:
         {
           eEffect = EffectSummonCreature("mothsummondog3",VFX_NONE);
         }
     break;
     case ALIGNMENT_GOOD:
         {
           eEffect = EffectSummonCreature("mothsummondog2",VFX_NONE);
         }
     break;
     case ALIGNMENT_NEUTRAL:
         {
           eEffect = EffectSummonCreature("mothsummondog2",VFX_NONE);
         }
     break;
   }
  }
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, HoursToSeconds(40));
   return;
}
