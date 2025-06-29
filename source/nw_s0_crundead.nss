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
    if (nCasterLevel <= 11)
    {
        eSummon = EffectSummonCreature("mothundead1",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 12) && (nCasterLevel <= 13))
    {
        eSummon = EffectSummonCreature("mothundead2",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 14) && (nCasterLevel <= 15))
    {
        eSummon = EffectSummonCreature("mothundead3",VFX_FNF_SUMMON_UNDEAD); // change later
    }
    else if ((nCasterLevel >= 15))
    {
        eSummon = EffectSummonCreature("mothundead4",VFX_FNF_SUMMON_UNDEAD);
    }
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}

