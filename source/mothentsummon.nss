//mothentsummon
#include "x2_inc_spellhook"
#include "X0_I0_SPELLS"
void main()
{
    int nDuration = 40;
    float fDelay = GetRandomDelay(0.3, 1.0);
    float fVector=0.0;
    location lTarget = GetSpellTargetLocation();
    location lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
    effect eSummon;
    int cnt = 7;
    int cnt2 = 0;
    while(cnt2<cnt)
         {
         lSpawn = GenerateNewLocationFromLocation(lTarget,1.5,fVector,fVector);
         eSummon = EffectSummonCreature("enttwigs",VFX_NONE,fDelay);
         ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, HoursToSeconds(nDuration));
         fVector +=40;
         cnt2=cnt2+1;
         }
}
