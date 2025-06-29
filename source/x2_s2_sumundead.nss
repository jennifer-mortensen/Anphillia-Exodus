#include "x2_inc_spellhook"
void PMUpgradeSummon(object oSelf, string sScript)
{
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oSelf);
    ExecuteScript ( sScript, oSummon);
}

void main()
{
    int nLevel =  GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
    effect eSummon;
    MothUnsummonMultipleSummons();
    float fDelay = 3.0;
    int nDuration = 14 + nLevel;
    if (nLevel <= 10)
        eSummon = EffectSummonCreature("mothplanar1b",VFX_FNF_SUMMON_UNDEAD);
    if (nLevel >= 11)
        eSummon = EffectSummonCreature("mothplanar1a",VFX_FNF_SUMMON_UNDEAD);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}




