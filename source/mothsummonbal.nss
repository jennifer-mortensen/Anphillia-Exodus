#include "x2_inc_spellhook"
void main()
{
object oPC;
oPC = GetItemActivator();
object oCaster;
oCaster = oPC;
object oTarget;
oTarget = GetItemActivatedTarget();
effect eSummon;
MothUnsummonMultipleSummons();
effect eVis = EffectVisualEffect(VFX_FNF_FIRESTORM);
effect eIn = EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10);
effect eOut = EffectVisualEffect(481);
effect eLink = EffectLinkEffects(eVis, eIn);
eSummon = EffectSummonCreature("mothbalrog2",VFX_FNF_SUMMON_GATE, 3.8f);
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon,GetSpellTargetLocation(), HoursToSeconds(40));
DelayCommand(1.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eLink,GetSpellTargetLocation()));
DelayCommand(3.3f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eOut,GetSpellTargetLocation()));
}

