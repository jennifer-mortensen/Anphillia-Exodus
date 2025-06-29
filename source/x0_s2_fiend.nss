#include "x2_inc_spellhook"
void main()
{
    int nLevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD, OBJECT_SELF);
    effect eSummon;
    MothUnsummonMultipleSummons();
    float fDelay = 2.0;
    int nDuration = nLevel*2;

    if (nLevel < 9)
    {
        eSummon = EffectSummonCreature("mothplanar3b",VFX_FNF_SUMMON_GATE, fDelay);
    }
    else if (nLevel < 15 )
    {
        eSummon = EffectSummonCreature("mothplanar3b", VFX_FNF_SUMMON_GATE, fDelay);
    }
    else
    {
       if (GetHasFeat(1003,OBJECT_SELF)) // epic fiend feat
       {
           eSummon = EffectSummonCreature("summonedhawkman", VFX_FNF_SUMMON_GATE, fDelay);
       }
       else
       {
        eSummon = EffectSummonCreature("mothplanar3b", VFX_FNF_SUMMON_GATE, fDelay);
       }
    }
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}
