#include "x2_inc_spellhook"
void main()
{

    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    effect eSummon = EffectSummonCreature("mordenkainensswo");
    MothUnsummonMultipleSummons();
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
}
