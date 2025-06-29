#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
       {
        return;
       }
    int nDuration = 40;
    object oTarget = GetSpellTargetObject();
    location lTarget = GetSpellTargetLocation();
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;
    MothUnsummonMultipleSummons();
    eSummon = ExtraordinaryEffect(eSummon);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
        switch (nAlign)
        {
            case ALIGNMENT_EVIL:
                eSummon = EffectSummonCreature("mothmumdust1",496,1.0f);
            break;
            case ALIGNMENT_GOOD:
                eSummon = EffectSummonCreature("mothmumdust",496,1.0f);
            break;
            case ALIGNMENT_NEUTRAL:
                eSummon = EffectSummonCreature("mothmumdust",496,1.0f);
            break;
        }
    DelayCommand(1.8,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis,lTarget));
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon,lTarget, HoursToSeconds(nDuration));
}


