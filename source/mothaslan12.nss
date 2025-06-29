#include "x2_inc_spellhook"
void main()
{
    //Declare major variables
    object oPC = GetItemActivator();
    if (GetIsObjectValid(GetItemActivatedTarget()))

    {
    SendMessageToPC(GetItemActivator(), "Improper use of item!");
    return;}
    int nDuration = 50;
    float fSeconds = HoursToSeconds(nDuration);
    effect eSummon;
    MothUnsummonMultipleSummons();
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
    location lSpellTargetLOC = GetItemActivatedTargetLocation();
    if (GetLocalString(oPC,"MothSetFactionInt") == "MothAxfellMember")
    {
        eSummon = EffectSummonCreature("lampshade001",VFX_FNF_SUMMON_GATE,3.0);
        DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpellTargetLOC, fSeconds));

    }
    else
    {
        eSummon = EffectSummonCreature("lampshade",VFX_FNF_SUMMON_CELESTIAL,3.0);
        DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpellTargetLOC, fSeconds));

    }
}

