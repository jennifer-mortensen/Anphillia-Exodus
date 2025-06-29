#include "x2_inc_spellhook"
#include "X0_I0_SPELLS"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    float fDelay = GetRandomDelay(0.3, 1.0);
    float fVector=0.0;
    MothUnsummonMultipleSummons();
    nDuration = nCasterLevel;
    nCasterLevel = nCasterLevel/9;
    location lTarget = GetSpellTargetLocation();
    location lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
    effect eSummon;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }
    int cnt = 1+nCasterLevel;
    int cnt2 = 0;
    while(cnt2<cnt)
    {
        lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
        eSummon = EffectSummonCreature("mothdruidswarm",VFX_NONE,fDelay);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, TurnsToSeconds(nDuration));
        fVector +=40;
        cnt2=cnt2+1;
    }
}


