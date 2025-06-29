//mothbardsum2
#include "x2_inc_spellhook"
#include "X0_I0_SPELLS"
void main()
{
    if (!GetHasFeat(FEAT_BARD_SONGS, OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85587,OBJECT_SELF);
    }
    else
    {
        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
        if(GetGender(OBJECT_SELF) == GENDER_FEMALE)
        {
            PlaySound("as_pl_chantingf2");
        }
        else
        {
            PlaySound("as_pl_chantingm2");
        }
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (GetIsPC(OBJECT_SELF)==FALSE)
    {
       return;
    }
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = 20;
    float fDelay = GetRandomDelay(0.3, 1.0);
    float fVector=0.0;
    MothUnsummonMultipleSummons();
    nDuration = nCasterLevel;
    location lTarget = GetSpellTargetLocation();
    location lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
    effect eSummon;
    if (GetLocalString(OBJECT_SELF,"MothSetFactionInt") == "MothAxfellMember")
    {
        int cnt = 4+d4();
        int cnt2 = 0;
            while(cnt2<cnt)
            {
                //Skeleton Chieftains
                lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
                eSummon = EffectSummonCreature("mothbardsum",VFX_NONE,fDelay);
                ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, HoursToSeconds(nDuration));
                fVector +=40;
                cnt2=cnt2+1;
            }
           ClearAllActions();
    }
    else
    {
        int cnt = 4+d4();
        int cnt2 = 0;
            while(cnt2<cnt)
            {
                //Skeleton Chieftains
                lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
                eSummon = EffectSummonCreature("mothbardsum2",VFX_NONE,fDelay);
                ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, HoursToSeconds(nDuration));
                fVector +=40;
                cnt2=cnt2+1;
            }
           ClearAllActions();
    }
  }
}
