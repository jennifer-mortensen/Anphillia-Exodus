#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oPC = OBJECT_SELF;
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_CLERIC, oPC);
    effect eSummon;
    MothUnsummonMultipleSummons();
    if (nCasterLevel <= 11)
    {
        eSummon = EffectSummonCreature("mothplanar1",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 12) && (nCasterLevel <= 25))
    {
        eSummon = EffectSummonCreature("mothplanar2",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 26) && (nCasterLevel <= 37))
    {
        eSummon = EffectSummonCreature("mothplanar3",460); // change later
    }
    else if ((nCasterLevel >= 38) && (nCasterLevel <= 39))
    {
        eSummon = EffectSummonCreature("mothplanar4",464);
    }
    else
    {
        eSummon = EffectSummonCreature("epicshadowlord",464);
    }
    eSummon = ExtraordinaryEffect(eSummon);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nCasterLevel));
}


