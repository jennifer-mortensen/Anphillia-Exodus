#include "x2_inc_spellhook"
#include "X0_I0_SPELLS"
void main()
{
    if (!GetHasFeat(FEAT_BARD_SONGS, OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85587,OBJECT_SELF); // no more bardsong uses left
        return;
    }
    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF); // not useable when silenced
        return;
    }
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (GetIsPC(OBJECT_SELF)==FALSE)
    {
       return;
    }
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF)-6;
    if (nCasterLevel <1)
    {
        nCasterLevel =1;
    }
    int nDuration = GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF);
    string sString1 = "mothsong3cl1";
    string sString2 = "mothsong3cl2";
    string sString3 = "mothsong3cl3";
    float fDelay = GetRandomDelay(0.3, 1.0);
    float fVector=0.0;
    MothUnsummonMultipleSummons();
    nDuration = nCasterLevel;
    location lTarget = GetSpellTargetLocation();
    location lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
    effect eSummon;
    DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
    PlaySound("sim_mentcharm");
    PlaySound("as_an_dragonror1");
    PlaySound("as_an_dragonror2");
    if (GetLocalString(OBJECT_SELF,"MothSetFactionInt") == "MothAxfellMember")
    {
        sString1 = "mothsong3ax1";
        sString2 = "mothsong3ax2";
        sString3 = "mothsong3ax3";
    }
    //Summon the appropriate creature based on the summoner level
    if (nCasterLevel <= 6)
    {
        int cnt = 1;
        int cnt2 = 0;
        while(cnt2<cnt)
        {
            lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
            eSummon = EffectSummonCreature(sString1,VFX_NONE,fDelay);
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
            lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
            eSummon = EffectSummonCreature(sString2,VFX_NONE,fDelay);
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
            lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
            eSummon = EffectSummonCreature(sString3,VFX_NONE,fDelay);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, HoursToSeconds(nDuration));
            fVector +=40;
            cnt2=cnt2+1;
        }
    }
}





