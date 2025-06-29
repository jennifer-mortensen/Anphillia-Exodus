#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    effect eSummon;
    MothUnsummonMultipleSummons();
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    location lSpellTargetLOC = GetSpellTargetLocation();
    int nSummonMode = GetLocalInt(GetItemPossessedBy(OBJECT_SELF, "MothBattleHorn"), "SUMMON_MODE");
    if((AnphFastGetPlayerTeamInt(OBJECT_SELF)==2 && nSummonMode != 1) || nSummonMode == 2)
    {
        eSummon = EffectSummonCreature("mothbalor1",VFX_FNF_SUMMON_GATE,3.0);
        float fSeconds = RoundsToSeconds(nDuration)*2;
        DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpellTargetLOC, fSeconds));

    }
    else
    {
        eSummon = EffectSummonCreature("mothbalor2",VFX_FNF_SUMMON_CELESTIAL,3.0);
        float fSeconds = RoundsToSeconds(nDuration)*2;
        DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpellTargetLOC, fSeconds));

    }
}
