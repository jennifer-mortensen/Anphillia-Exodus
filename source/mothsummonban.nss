#include "x2_inc_spellhook"
void main()
{
object oPC;
if (GetIsObjectValid(GetItemActivatedTarget()))

{
SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}
oPC = GetItemActivator();
object oCaster;
oCaster = oPC;
object oTarget;
oTarget = GetItemActivatedTarget();
effect eSummon;
MothUnsummonMultipleSummons();
effect eVis = EffectVisualEffect(VFX_FNF_IMPLOSION);
effect eIn = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
effect eLow = EffectVisualEffect(VFX_FNF_DEMON_HAND);
effect eOut = EffectVisualEffect(VFX_IMP_HARM);
effect eBack = EffectVisualEffect(VFX_FNF_UNDEAD_DRAGON);
effect eHowl = EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES);

eSummon = EffectSummonCreature("summonedbanshee",VFX_FNF_SCREEN_SHAKE,7.0f );
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon,GetSpellTargetLocation(), HoursToSeconds(40));
DelayCommand(3.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eBack,GetSpellTargetLocation()));
DelayCommand(2.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis,GetSpellTargetLocation()));
DelayCommand(2.5f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eIn,GetSpellTargetLocation()));
DelayCommand(6.5f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eOut,GetSpellTargetLocation()));
DelayCommand(5.5f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eHowl,GetSpellTargetLocation()));
DelayCommand(6.5f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eIn,GetSpellTargetLocation()));
DelayCommand(6.8f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eLow,GetSpellTargetLocation()));
}


