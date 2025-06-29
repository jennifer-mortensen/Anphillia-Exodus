#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
       {
        return;
       }
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
    int nDuration = 14 + nCasterLevel;
    effect eSummon;
    effect eSummonSwarm1;
    effect eSummonSwarm2;
    effect eSummonSwarm3;
    effect eSummonSwarm4;
    effect eSummonSwarm5;
    MothUnsummonMultipleSummons();
    if (nCasterLevel <=9)
    {
        eSummon = EffectSummonCreature("mothplanar1b",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel <=10))
    {
        eSummon = EffectSummonCreature("mothplanar1a",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel <=19))
    {
        eSummon = EffectSummonCreature("mothgreater3",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel <=28))
    {
        eSummon = EffectSummonCreature("mothgreater3b",VFX_FNF_SUMMON_EPIC_UNDEAD);
    }
    else
    {
       eSummon = EffectSummonCreature("mothgreater3b",VFX_FNF_SUMMON_EPIC_UNDEAD);
       eSummonSwarm1 = EffectSummonCreature("mothpmswarm",VFX_NONE);
       eSummonSwarm2 = EffectSummonCreature("mothpmswarm",VFX_NONE);
       eSummonSwarm3 = EffectSummonCreature("mothpmswarm",VFX_NONE);
       eSummonSwarm4 = EffectSummonCreature("mothpmswarm",VFX_NONE);
       eSummonSwarm5 = EffectSummonCreature("mothpmswarm",VFX_NONE);
       eSummonSwarm1 = ExtraordinaryEffect(eSummonSwarm1);
       eSummonSwarm2 = ExtraordinaryEffect(eSummonSwarm2);
       eSummonSwarm3 = ExtraordinaryEffect(eSummonSwarm3);
       eSummonSwarm4 = ExtraordinaryEffect(eSummonSwarm4);
       eSummonSwarm5 = ExtraordinaryEffect(eSummonSwarm5);
       ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummonSwarm1, GetSpellTargetLocation(), HoursToSeconds(nDuration));
       ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummonSwarm2, GetSpellTargetLocation(), HoursToSeconds(nDuration));
       ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummonSwarm3, GetSpellTargetLocation(), HoursToSeconds(nDuration));
       ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummonSwarm4, GetSpellTargetLocation(), HoursToSeconds(nDuration));
       ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummonSwarm5, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    }
    eSummon = ExtraordinaryEffect(eSummon);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_LOS_EVIL_10),GetSpellTargetLocation());
}





