#include "x2_inc_spellhook"
void main()
{
object oPC = GetItemActivator();
if (GetIsObjectValid(GetItemActivatedTarget()))
{
SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;
}
object oCaster;
oCaster = oPC;
object oTarget;
oTarget = GetItemActivatedTarget();
effect eSummon;
MothUnsummonMultipleSummons();
effect eVis = EffectVisualEffect(VFX_FNF_FIRESTORM);
effect eIn = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
effect eLow = EffectVisualEffect(VFX_FNF_DEMON_HAND);
effect eOut = EffectVisualEffect(VFX_IMP_HEALING_X);
effect eBack = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
effect eHowl = EffectVisualEffect(VFX_FNF_SUMMON_GATE);

eSummon = EffectSummonCreature("summonedspirit",VFX_FNF_SCREEN_SHAKE,7.3f );
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon,GetSpellTargetLocation(), HoursToSeconds(40));
DelayCommand(3.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eBack,GetSpellTargetLocation()));
DelayCommand(2.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis,GetSpellTargetLocation()));
DelayCommand(2.5f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eIn,GetSpellTargetLocation()));
DelayCommand(6.8f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eOut,GetSpellTargetLocation()));
DelayCommand(4.5f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eHowl,GetSpellTargetLocation()));
DelayCommand(4.5f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eIn,GetSpellTargetLocation()));
DelayCommand(5.8f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eLow,GetSpellTargetLocation()));
}


