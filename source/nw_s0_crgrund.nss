#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel;
    nDuration = 24;
    effect eSummon;
    MothUnsummonMultipleSummons();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    if (nCasterLevel <= 19)
    {
        eSummon = EffectSummonCreature("mothundead3",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 20) && (nCasterLevel <= 25))
    {
        eSummon = EffectSummonCreature("mothgreater1",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 26) && (nCasterLevel <= 34))
    {
        eSummon = EffectSummonCreature("mothgreater2",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 35) && (nCasterLevel <= 39))
    {
        eSummon = EffectSummonCreature("mothgreater3",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 40))
    {
        eSummon = EffectSummonCreature("mothgreater3x",VFX_FNF_SUMMON_EPIC_UNDEAD);
    }
    DelayCommand(1.5,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration)));
}

