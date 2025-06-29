#include "x2_inc_spellhook"
#include "X0_I0_SPELLS"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    MothUnsummonMultipleSummons();

    int nDuration = 10; //10 rounds.
    int i;
    float fDelay = GetRandomDelay(0.3, 1.0);
    float fVector = 0.0;
    location lTarget = GetSpellTargetLocation();
    location lSpawn;
    effect eSummon;
    string sSummon;
    int nAppearance = GetAppearanceType(OBJECT_SELF);

    if(nAppearance == 370) //370 = Epic Medusa
    {
        sSummon = "sum_epicmedsnake";
    }
    else
    {
        sSummon = "sum_medsnake";
    }

    while(i < 6)
    {
        lSpawn = GenerateNewLocationFromLocation(lTarget, 1.5, fVector, fVector);
        eSummon = EffectSummonCreature(sSummon, VFX_NONE, fDelay);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, RoundsToSeconds(nDuration));
        fVector += 40;
        i++;
    }
}





