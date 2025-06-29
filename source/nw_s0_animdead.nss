#include "x2_inc_spellhook"
#include "X0_I0_SPELLS"
#include "_inc_summons"
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
    location lTarget = GetSpellTargetLocation();
    location lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
    effect eSummon;

    string sLesserUndead;
    string sUndead;
    string sGreaterUndead;

    int nSummonType = GetSummonType(OBJECT_SELF, SUMMON_GROUP_UNDEAD); //J. Persinne; players can now set the type of undead they would like to summon to good or evil.

    if(nSummonType == UNDEAD_SUMMON_TYPE_RANDOM)
        nSummonType = d2();

    switch(nSummonType)
    {
        case UNDEAD_SUMMON_TYPE_EVIL:
            sLesserUndead = "mothzombie";
            sUndead = "mothskelly";
            sGreaterUndead = "mothundeadgroup";
            break;
        case UNDEAD_SUMMON_TYPE_GOOD:
            sLesserUndead = "ad_lsrguardian";
            sUndead = "ad_guardian";
            sGreaterUndead = "ad_grtrguardian";
            break;
    }

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
            eSummon = EffectSummonCreature(sLesserUndead, VFX_NONE,fDelay);
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
            eSummon = EffectSummonCreature(sUndead, VFX_NONE,fDelay);
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
            eSummon = EffectSummonCreature(sGreaterUndead, VFX_NONE,fDelay);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, HoursToSeconds(nDuration));
            fVector +=40;
            cnt2=cnt2+1;
        }
    }
}





