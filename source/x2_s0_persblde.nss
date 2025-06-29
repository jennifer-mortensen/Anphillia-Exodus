#include "x2_inc_spellhook"
#include "X0_I0_SPELLS"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nCasterLevel2 = nCasterLevel;
    int nDuration = nCasterLevel;
    float fDelay = GetRandomDelay(0.3, 1.0);
    float fVector=0.0;
    MothUnsummonMultipleSummons();
    nDuration = nCasterLevel*4;
    nCasterLevel = nCasterLevel/9;
    location lTarget = GetSpellTargetLocation();
    location lSpawn = GenerateNewLocationFromLocation(lTarget,1.0,fVector,fVector);
    effect eSummon;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }
    int cnt = 2+nCasterLevel;
    int cnt2 = 0;
    while(cnt2<cnt)
    {
        lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
        eSummon = EffectSummonCreature("X2_S_FAERIE001",VFX_NONE,fDelay);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, RoundsToSeconds(nDuration));
        fVector +=40;
        cnt2=cnt2+1;
    }
    DelayCommand(1.5,MothGiveDaggerBonus(nCasterLevel2));
}


