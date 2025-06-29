//pack of wolves
#include "x2_inc_spellhook"
#include "X0_I0_SPELLS"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (GetIsPC(OBJECT_SELF)==FALSE)
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
    location lTarget = GetSpellTargetLocation();
    location lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
    effect eSummon;
    //Metamagic extension if needed
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }
    //Summon the appropriate creature based on the summoner level
    if (nCasterLevel <= 6)
    {
        int cnt = 1;
        int cnt2 = 0;
        while(cnt2<cnt)
        {
            //Zombies
            lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
            eSummon = EffectSummonCreature("mothwolf1",VFX_NONE,fDelay);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, HoursToSeconds(nDuration));
            fVector +=40;
            cnt2=cnt2+1;
        }
    }
    else if ((nCasterLevel >= 6) && (nCasterLevel <= 18))
    {
        int cnt = nCasterLevel/6+1;
        int cnt2 = 0;
        while(cnt2<cnt)
        {
            //Skeleton Warriors
            lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
            eSummon = EffectSummonCreature("mothwolf2",VFX_NONE,fDelay);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, HoursToSeconds(nDuration));
            fVector +=40;
            cnt2=cnt2+1;
        }
    }
    else
    {
        int cnt = nCasterLevel/6;
        int cnt2 = 0;
        while(cnt2<cnt)
        {
            //Skeleton Chieftains
            lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
            eSummon = EffectSummonCreature("mothwolf3",VFX_NONE,fDelay);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, HoursToSeconds(nDuration));
            fVector +=40;
            cnt2=cnt2+1;
        }
    }
}





