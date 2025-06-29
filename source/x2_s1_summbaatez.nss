#include "x2_i0_spells"
void main()
{
    MothUnsummonMultipleSummons();
    effect eSummon = EffectSummonCreature("x2_erinyes",VFX_FNF_SUMMON_MONSTER_3);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(24));
}
