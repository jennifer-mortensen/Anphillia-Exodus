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
effect eVis = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
effect eIn = EffectVisualEffect(VFX_DUR_DARKNESS);
effect eOut = EffectVisualEffect(464);
effect eLink = EffectLinkEffects(eVis, eIn);
eSummon = EffectSummonCreature("mothdeamon2",VFX_FNF_SUMMON_EPIC_UNDEAD, 3.8f);
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon,GetSpellTargetLocation(), HoursToSeconds(40));
DelayCommand(1.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eLink,GetSpellTargetLocation()));
DelayCommand(3.3f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eOut,GetSpellTargetLocation()));
}


